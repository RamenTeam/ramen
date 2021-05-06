import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/config/rtc.dart';
import 'package:noodle/src/core/models/signaling_status.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/pages/call/bloc/signaling_bloc.dart';
import 'package:noodle/src/resources/pages/call/bloc/signaling_event.dart';
import 'package:noodle/src/resources/pages/call/bloc/signaling_state.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe

class CallScreen extends StatefulWidget {
  CallScreen({Key? key}) : super(key: key);

  static Route route({required User peer}) {
    return MaterialPageRoute<void>(builder: (_) => CallScreen());
  }

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  onStartHandler() {
    rtcPeerToPeer.initRenderer();

    rtcPeerToPeer.createPC().then((pc) => rtcPeerToPeer.setPeerConnection(pc));

    print("🔔🔔🔔 Starting...");

    rtcSignaling.onStateChange = (SignalingStatus status) {
      switch (status) {
        case SignalingStatus.MATCHING:
          Provider.of<SignalingBloc>(context, listen: false)
              .add(SignalingStatusChanged(SignalingStatus.MATCHING));
          break;
        case SignalingStatus.FINDING:
          Provider.of<SignalingBloc>(context, listen: false)
              .add(SignalingStatusChanged(SignalingStatus.FINDING));
          break;
        case SignalingStatus.DISCONNECTED:
          Provider.of<SignalingBloc>(context, listen: false)
              .add(SignalingStatusChanged(SignalingStatus.DISCONNECTED));
          break;
        case SignalingStatus.ABORTING:
          Provider.of<SignalingBloc>(context, listen: false)
              .add(SignalingStatusChanged(SignalingStatus.ABORTING));
          break;
        case SignalingStatus.IDLE:
          Provider.of<SignalingBloc>(context, listen: false)
              .add(SignalingStatusChanged(SignalingStatus.IDLE));
          break;
        case SignalingStatus.NO_PEER_FOUND:
          Provider.of<SignalingBloc>(context, listen: false)
              .add(SignalingStatusChanged(SignalingStatus.NO_PEER_FOUND));
          break;
      }
    };

    rtcSignaling.connect();
  }

  onEndHandler() {
    print("🔔🔔🔔 Ending...");
    rtcSignaling.disconnect();
    rtcPeerToPeer.bye();
  }

  @override
  void initState() {
    onStartHandler();
    super.initState();
  }

  Container buildRemoteCamera() => Container(
        key: Key("remote"),
        child: RTCVideoView(
          rtcPeerToPeer.remoteRenderer,
          mirror: true,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        ),
      );

  Scaffold buildScaffold(List<Widget> remoteChildren) => Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: Stack(children: [
          // ...remoteChildren,
          buildRemoteCamera(),
          Column(
            children: [
              // Top
              _TopSection(
                onEndHandler: onEndHandler,
              ),
              // Middle
              _MiddleSection()
            ],
          )
        ]),
      ));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignalingBloc, SignalingState>(
        builder: (context, state) {
      switch (state.status) {
        case SignalingStatus.FINDING:
          return buildScaffold([
            Center(
                child: SpinKitCircle(
              color: Theme.of(context).primaryColor,
              size: 50.0,
            )),
          ]);
        case SignalingStatus.MATCHING:
          return buildScaffold([]);
        default:
          return Container();
      }
    });
  }
}

class _TopSection extends StatelessWidget {
  _TopSection({required this.onEndHandler});

  final dynamic onEndHandler;

  @override
  Widget build(BuildContext context) {
    User? peer; //TODO
    List<Widget> buildInfo() {
      return [
        // Avatar
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          child: ClipRRect(
            child: Image.network(
                "https://th.bing.com/th/id/OIP.xzIfQQCZiBpvccxSZUsOSAHaHa?pid=ImgDet&rs=1"),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(width: 10),
        // Name & Username
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 200,
              child: Text(
                'Tin Chung',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
              alignment: Alignment.centerLeft,
            ),
            Container(
              height: 30,
              width: 200,
              child: Text(
                '@tinchung',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              alignment: Alignment.centerLeft,
            )
          ],
        )
      ];
    }

    Widget buildBackButton() {
      return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).primaryColor),
          child: IconButton(
              icon: FaIcon(FontAwesomeIcons.home),
              onPressed: () {
                onEndHandler();
                Navigator.pop(context);
              }));
    }

    return Container(
        height: 90,
        color: Colors.black54,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                children: peer == null
                    ? [
                        Text(
                          "Finding...",
                          style: Theme.of(context).textTheme.headline1,
                        )
                      ]
                    : buildInfo()),
            Spacer(),
            buildBackButton()
          ],
        ));
  }
}

class _MiddleSection extends StatelessWidget {
  Widget buildInteractionButtons(BuildContext context) {
    return Container(
      width: 90,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).primaryColor),
            child: IconButton(
                icon: FaIcon(FontAwesomeIcons.camera),
                onPressed: rtcPeerToPeer.switchCamera))
      ]),
    );
  }

  Widget buildCamera() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          key: Key("local"),
          width: 150,
          height: 230,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: RTCVideoView(
              rtcPeerToPeer.localRenderer,
              mirror: true,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          margin: EdgeInsets.only(left: 20, bottom: 20),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [buildCamera(), Spacer(), buildInteractionButtons(context)],
    ));
  }
}
