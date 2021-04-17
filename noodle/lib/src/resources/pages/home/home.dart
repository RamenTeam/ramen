import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/bloc/matching/matching_bloc.dart';
import 'package:noodle/src/core/bloc/matching/matching_event.dart';
import 'package:noodle/src/core/bloc/matching/matching_state.dart';
import 'package:noodle/src/resources/pages/interaction/meeting.dart';
import 'package:noodle/src/resources/shared/app_bar.dart';
import 'package:noodle/src/resources/theme/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MatchingBloc, MatchingState>(
      listener: (context, state) {
        switch (state.status) {
          case MatchingStatus.MATCHING:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MeetingScreen()));
            return;
          default:
            return;
        }
      },
      child: Scaffold(
          appBar: SharedAppBar(
            authBloc: Provider.of<AuthenticationBloc>(context, listen: false),
            title: 'Ramen',
          ),
          backgroundColor: Theme.of(context).accentColor,
          body: _HomeScreenBody()),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchingBloc, MatchingState>(builder: (context, state) {
      switch (state.status) {
        default:
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Banner(),
                SizedBox(height: 20),
                _Title(),
                SizedBox(height: 5),
                _Tooltip(),
                SizedBox(height: 30),
                _FindButton(),
              ],
            ),
          );
      }
    });
  }
}

class _FindButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Container spinKitThreeBounce({required bool visible}) {
      return Container(
        child: Visibility(
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          visible: visible,
          child: SpinKitThreeBounce(
            color: Theme.of(context).textTheme.headline1?.color,
            size: 20,
          ),
        ),
      );
    }

    return BlocBuilder<MatchingBloc, MatchingState>(builder: (context, state) {
      bool isFinding = state.status == MatchingStatus.FINDING;
      return ClipOval(
        child: Material(
          color: isFinding
              ? Colors.red
              : Theme.of(context).primaryColor, // button color
          child: InkWell(
            splashColor: Colors.red, // inkwell color
            child: SizedBox(
                width: 60,
                height: 60,
                child: Center(
                    child: isFinding
                        ? spinKitThreeBounce(visible: isFinding)
                        : FaIcon(
                            FontAwesomeIcons.play,
                            color: Theme.of(context).textTheme.headline1?.color,
                            size: 18,
                          ))),
            onTap: () {
              // ignore: close_sinks
              MatchingBloc matchingBloc =
                  BlocProvider.of<MatchingBloc>(context);
              switch (state.status) {
                case MatchingStatus.FINDING:
                  matchingBloc.add(MatchingStatusChanged(MatchingStatus.IDLE));
                  break;
                case MatchingStatus.PEER_REQUEST:
                  matchingBloc.add(MatchingStatusChanged(MatchingStatus.IDLE));
                  break;
                case MatchingStatus.IDLE:
                  matchingBloc
                      .add(MatchingStatusChanged(MatchingStatus.FINDING));
                  break;
                default:
                  matchingBloc
                      .add(MatchingStatusChanged(MatchingStatus.FINDING));
                  break;
              }
            },
          ),
        ),
      );
    });
  }
}

class _Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchingBloc, MatchingState>(builder: (context, state) {
      bool isFinding = state.status == MatchingStatus.FINDING;
      return Container(
        child: Image.asset(
          AppTheme.of(context).currentThemeKey == AppThemeKeys.dark
              ? isFinding
                  ? "assets/images/ramen-bowl-dark.png"
                  : "assets/images/ramen-jumbotron-dark.png"
              : isFinding
                  ? "assets/images/ramen-bowl-light.png"
                  : "assets/images/ramen-jumbotron-light.png",
          height: 200,
        ),
      );
    });
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget inner({required String text}) {
      return Text(
        text,
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline1?.color),
      );
    }

    return BlocBuilder<MatchingBloc, MatchingState>(builder: (context, state) {
      switch (state.status) {
        case MatchingStatus.FINDING:
          return inner(text: "Find a partner...");
        case MatchingStatus.PEER_NOT_FOUND:
          return inner(text: "No one online 😥");
        case MatchingStatus.IDLE:
          return inner(text: "Welcome to Ramen!");
        default:
          return inner(text: "Welcome to Ramen!");
      }
    });
  }
}

class _Tooltip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget inner({required String text}) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 17,
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
      );
    }

    return BlocBuilder<MatchingBloc, MatchingState>(builder: (context, state) {
      switch (state.status) {
        case MatchingStatus.FINDING:
          return inner(text: "Click a button to cancel");
        case MatchingStatus.PEER_NOT_FOUND:
          return inner(text: "Maybe someone is online now. Try again!");
        case MatchingStatus.IDLE:
          return inner(text: "Only 30 seconds for a conversation.");
        default:
          return inner(text: "Only 30 seconds for a conversation.");
      }
    });
  }
}
