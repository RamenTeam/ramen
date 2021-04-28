import 'package:flutter_webrtc/flutter_webrtc.dart';

class RTCSandBox {
  final _localRenderer = new RTCVideoRenderer();

  initRenderer() {
    _localRenderer.initialize();
  }

  getUserMedia() async {
    final Map<String, dynamic> constraints = {
      "audio": false,
      "video": {
        "facingMode": "user",
      }
    };

    MediaStream stream = await navigator.mediaDevices.getUserMedia(constraints);

    _localRenderer.srcObject = stream;
  }

  dispose() {
    _localRenderer.dispose();
  }

  get localRenderer {
    return this._localRenderer;
  }
}
