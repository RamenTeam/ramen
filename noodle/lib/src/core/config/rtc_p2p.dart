import 'dart:convert';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logger/logger.dart';
import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/resources/pages/home/bloc/matching/matching_state.dart';
import 'package:sdp_transform/sdp_transform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RTCPeerToPeer {
  bool _offer = false;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  bool isFrontCamera = true;

  initRenderer() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
  }

  Future<RTCPeerConnection> createPC() async {
    SharedPreferences pref = await getSharedPref();
    Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"}
      ]
    };

    // SDP: Session Description Protocol
    final Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {"OfferToReceiveAudio": true, "OfferToReceiveVideo": true},
      "optional": []
    };

    // Get local user media
    _localStream = await getUserMedia();

    // Create a peer connection
    RTCPeerConnection pc =
        await createPeerConnection(configuration, offerSdpConstraints);

    // Add a local stream to peer connection
    pc.addStream(_localStream!);

    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        print("🌲🌲🌲 onIceCandidate");
        if (pref.getString(RTC_CANDIDATE) == null) {
          pref.setString(
              RTC_CANDIDATE,
              json.encode({
                'candidate': e.candidate.toString(),
                'sdpMid': e.sdpMid.toString(),
                'sdpMlineIndex': e.sdpMlineIndex
              }));
        }
        print(json.encode({
          'candidate': e.candidate.toString(),
          'sdpMid': e.sdpMid.toString(),
          'sdpMlineIndex': e.sdpMlineIndex
        }));
      }
    };

    pc.onIceConnectionState = (e) {
      print('🌲🌲🌲 onIceConnectionState $e');
      if (e == RTCIceConnectionState.RTCIceConnectionStateClosed ||
          e == RTCIceConnectionState.RTCIceConnectionStateFailed) {
        bye();
      }
    };

    pc.onAddStream = (stream) {
      print("🌲🌲🌲 onAddStream");
      new Logger().log(Level.verbose, 'Add Stream: ${stream.id}');
      _remoteRenderer.srcObject = stream;
    };

    // WORKAROUND FOR WEBRTC CHROME BUG
    bool negotiating = false;
    pc.onRenegotiationNeeded = () {
      print("🌲🌲🌲 onRenegotiationNeeded");
      try {
        // ignore: unrelated_type_equality_checks
        if (negotiating || pc.signalingState != "stable") return;
        negotiating = true;
        /* Your async/await-using code goes here */
      } finally {
        negotiating = false;
      }
    };

    return pc;
  }

  // #TODO get the user media (camera, audio...)
  Future<MediaStream> getUserMedia() async {
    final Map<String, dynamic> constraints = {
      "audio": false,
      "video": {
        "facingMode": "user",
      }
    };

    MediaStream stream = await navigator.mediaDevices.getUserMedia(constraints);

    _localRenderer.srcObject = stream;

    return stream;
  }

  Future<String> offer() async {
    // Step 1: caller creates offer
    RTCSessionDescription description =
        await _peerConnection!.createOffer({"offerToReceiveVideo": 1});
    var session = parse(description.sdp as String);
    print(json.encode(session));
    _offer = true;
    // Step 2: caller sets localDescription
    await _peerConnection!.setLocalDescription(description);
    return json.encode(session);
  }

  Future<String> answer() async {
    // Step 5: callee creates answer
    RTCSessionDescription description =
        await _peerConnection!.createAnswer({"offerToReceiveVideo": 1});

    var session = parse(description.sdp as String);
    print(json.encode(session));
    _offer = false;
    // Step 6: callee sets local description
    await _peerConnection!.setLocalDescription(description);
    return json.encode(session);
  }

  /// #TODO setRemoteDescription
  /// #1 decode session from the JSON input sdp (textField)
  /// #2 rewrite the sdp with the decoded session
  /// #3 create a description with the sdp, type as [answer/offer]
  /// #4 setRemoteDescription for the peer connection
  void setRemoteDescription(String jsonString, String? type) async {
    dynamic session = await jsonDecode('$jsonString');

    String sdp = write(session, null);
    RTCSessionDescription description = new RTCSessionDescription(
        sdp, type == null ? (_offer ? "answer" : "offer") : type);

    new Logger().log(Level.info, json.encode(description.toMap()));

    await _peerConnection!.setRemoteDescription(description);
  }

  get signalingState => _peerConnection!.signalingState;

  void setCandidate(String jsonString) async {
    dynamic session = jsonDecode(jsonString);
    new Logger().log(Level.info, session['candidate']);
    dynamic candidate = new RTCIceCandidate(
        session['candidate'], session['sdpMid'], session['sdpMlineIndex']);
    new Logger().log(Level.info, candidate);
    await _peerConnection!.addCandidate(candidate);
  }

  void bye() {
    if (_localStream != null) {
      _localStream!.dispose();
      _localStream = null;
    }

    peerConnection.close();
  }

  void switchCamera() async {
    //TODO need to fix
    if (_localStream != null) {
      // ignore: deprecated_member_use
      bool value = await _localStream!.getVideoTracks()[0].switchCamera();
      while (value == this.isFrontCamera)
        // ignore: deprecated_member_use
        value = await _localStream!.getVideoTracks()[0].switchCamera();
      this.isFrontCamera = value;
    }
  }

  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
  }

  // getters & setters
  get localRenderer {
    return this._localRenderer;
  }

  get remoteRenderer {
    return this._remoteRenderer;
  }

  Map<String, dynamic> getState() {
    return {"_offer": _offer};
  }

  void setPeerConnection(RTCPeerConnection pc) {
    _peerConnection = pc;
  }

  RTCPeerConnection get peerConnection {
    return this._peerConnection!;
  }
}
