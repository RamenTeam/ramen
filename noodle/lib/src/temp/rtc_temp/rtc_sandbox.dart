import 'dart:convert';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logger/logger.dart';
import 'package:sdp_transform/sdp_transform.dart';

class RTCSandBox {
  bool _offer = false;
  late RTCPeerConnection _peerConnection;
  late MediaStream _localStream;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();

  initRenderer() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
  }

  Future<RTCPeerConnection> createPC() async {
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
    pc.addStream(_localStream);

    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        new Logger().log(
            Level.verbose,
            json.encode({
              'candidate': e.candidate.toString(),
              'sdpMid': e.sdpMid.toString(),
              'sdpMlineIndex': e.sdpMlineIndex
            }));
      }
    };

    pc.onIceConnectionState = (e) {
      new Logger().log(Level.verbose, e);
    };

    pc.onAddStream = (stream) {
      new Logger().log(Level.verbose, 'Add Stream: ${stream.id}');
      _remoteRenderer.srcObject = stream;
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

  /// #TODO create offer
  /// #1 peer connection create connection with options -> description
  /// #2 get the session from the created description
  /// #3 set the state as [offer = true]
  /// #4 setLocalDescription for the peer connection
  Future<String> offer() async {
    RTCSessionDescription description =
        await _peerConnection.createOffer({"offerToReceiveVideo": 1});
    var session = parse(description.sdp as String);
    print(json.encode(session));
    _offer = true;
    await _peerConnection.setLocalDescription(description);
    return json.encode(session);
  }

  /// #TODO create offer
  /// #1 peer connection create connection with options -> description
  //  #2 get the session from the created description
  //  #3 set the state as [offer = false]
  //  #4 setLocalDescription for the peer connection
  void answer() async {
    RTCSessionDescription description =
        await _peerConnection.createAnswer({"offerToReceiveVideo": 1});

    var session = parse(description.sdp as String);
    new Logger().log(Level.info, json.encode(session));
    _offer = false;
    await _peerConnection.setLocalDescription(description);
  }

  /// #TODO setRemoteDescription
  /// #1 decode session from the JSON input sdp (textField)
  /// #2 rewrite the sdp with the decoded session
  /// #3 create a description with the sdp, type as [answer/offer]
  /// #4 setRemoteDescription for the peer connection
  void setRemoteDescription(String jsonString) async {
    dynamic session = await jsonDecode('$jsonString');

    String sdp = write(session, null);
    RTCSessionDescription description =
        new RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');

    new Logger().log(Level.info, json.encode(description.toMap()));

    await _peerConnection.setRemoteDescription(description);
  }

  void setCandidate(String jsonString) async {
    dynamic session = jsonDecode(jsonString);
    new Logger().log(Level.info, session['candidate']);
    dynamic candidate = new RTCIceCandidate(
        session['candidate'], session['sdpMid'], session['sdpMlineIndex']);
    await _peerConnection.addCandidate(candidate);
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
}
