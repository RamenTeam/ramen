import 'dart:convert';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logger/logger.dart';
import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/core/models/signaling_status.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:sdp_transform/sdp_transform.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void SignalingStateCallback(SignalingStatus state);

class RTCPeerToPeer {
  bool _offer = false;
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  SignalingStateCallback? onStateChange;
  var _remoteCandidates = [];
  var iceCandidates = [];
  bool isICEGathered = false;
  bool isFrontCamera = true;

  initRenderer() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
  }

  // SDP: Session Description Protocol
  final Map<String, dynamic> offerSdpConstraints = {
    "mandatory": {"OfferToReceiveAudio": true, "OfferToReceiveVideo": true},
    "optional": []
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
      // {"url": "stun:113.172.205.34:443"},
      {
        'url': "turn:numb.vagenie.ca:3478",
        'username': "cqtin0903@gmail.com",
        'credential': "123456"
      },
      // {
      //   "url":"turn:littleramn.tk:443?transport=udp",
      //   "username":"admin",
      //   "credential":"admin"
      // }
    ]
  };

  Future<RTCPeerConnection> createPC() async {
    SharedPreferences pref = await getSharedPref();

    // Get local user media
    _localStream = await getUserMedia();

    // Create a peer connection
    RTCPeerConnection pc =
        await createPeerConnection(_iceServers, _config);

    // Add a local stream to peer connection
    pc.addStream(_localStream!);

    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        print("🌲🌲🌲 onIceCandidate");
        print(json.encode({
          'candidate': e.candidate.toString(),
          'sdpMid': e.sdpMid.toString(),
          'sdpMlineIndex': e.sdpMlineIndex
        }));
        if (isICEGathered){
          if (iceCandidates.length < 6){
            iceCandidates.add(json.encode({
              'candidate': e.candidate.toString(),
              'sdpMid': e.sdpMid.toString(),
              'sdpMlineIndex': e.sdpMlineIndex
            }));
          } else {
            isICEGathered = false;
          }
        }
        // if (pref.getString(RTC_CANDIDATE) == null) {
        //   print("!!!!! SET ICE CANDIDATE");
        //   pref.setString(
        //       RTC_CANDIDATE,
        //       json.encode({
        //         'candidate': e.candidate.toString(),
        //         'sdpMid': e.sdpMid.toString(),
        //         'sdpMlineIndex': e.sdpMlineIndex
        //       }));
        // }
      }
    };
    pc.onIceGatheringState = (e){
      print('🌲🌲🌲 onIceGatheringState $e');
      if (e == RTCIceGatheringState.RTCIceGatheringStateGathering){
        isICEGathered = true;
      }
      if (e == RTCIceGatheringState.RTCIceGatheringStateComplete){
        isICEGathered = false;
      }
    };

    pc.onIceConnectionState = (e) {
      print('🌲🌲🌲 onIceConnectionState $e');
      if (e == RTCIceConnectionState.RTCIceConnectionStateDisconnected) {
        this.onStateChange!(SignalingStatus.RECONNECTING);
      }
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
        await _peerConnection!.createOffer(offerSdpConstraints);
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
        await _peerConnection!.createAnswer(offerSdpConstraints);

    // Handle Remote Candidates
    if (this._remoteCandidates.length > 0) {
      _remoteCandidates.forEach((candidate) async {
        await peerConnection.addCandidate(candidate);
      });
      _remoteCandidates.clear();
    }

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
    handleRemoteCandidates(candidate);
  }

  void handleRemoteCandidates(RTCIceCandidate candidate) async {
    if (peerConnection != null) {
      await peerConnection.addCandidate(candidate);
    } else {
      _remoteCandidates.add(candidate);
    }
  }

  void bye() {
    if (_localStream != null) {
      _localStream!.dispose();
      _localStream = null;
    }
    _remoteCandidates.clear();
    peerConnection.close();
  }

  void deactivate() {
    // _localRenderer.dispose();
    // _remoteRenderer.dispose();
    _localStream?.dispose();
    _localStream = null;
    _peerConnection?.close();
    _peerConnection?.dispose();
    isICEGathered = false;
    iceCandidates.clear();
    _remoteCandidates.clear();
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;
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
