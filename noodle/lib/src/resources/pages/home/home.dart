import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/models/matching_status.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/home/bloc/matching/matching_bloc.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';
import 'package:noodle/src/resources/shared/home_app_bar.dart';
import 'package:noodle/src/resources/theme/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeAppBar(
          authBloc: Provider.of<AuthenticationBloc>(context, listen: false),
          title: 'Ramen',
          userCubit: Provider.of<UserCubit>(context, listen: false),
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: _HomeScreenBody());
  }
}

class _HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

    return ClipOval(
      child: Material(
        color: Theme.of(context).primaryColor, // button color
        child: InkWell(
          splashColor: Colors.red, // inkwell color
          child: SizedBox(
              width: 60,
              height: 60,
              child: Center(
                  child: FaIcon(
                FontAwesomeIcons.play,
                color: Theme.of(context).textTheme.headline1?.color,
                size: 18,
              ))),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<CallScreen>(
                builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<MatchingBloc>(context),
                    child: CallScreen()),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        AppTheme.of(context).currentThemeKey == AppThemeKeys.dark
            ? "assets/images/ramen-jumbotron-dark.png"
            : "assets/images/ramen-jumbotron-light.png",
        height: 200,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Welcome to Ramen!",
      style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.headline1?.color),
    );
  }
}

class _Tooltip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Only 30 seconds for a conversation.",
      style: TextStyle(
        fontSize: 17,
        color: Theme.of(context).textTheme.bodyText1?.color,
      ),
    );
  }
}
