import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/bloc/home/home_cubit.dart';
import 'package:noodle/src/core/bloc/home/home_state.dart';
import 'package:noodle/src/resources/shared/app_bar.dart';
import 'package:noodle/src/resources/theme/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SharedAppBar(
          authBloc: Provider.of<AuthenticationBloc>(context, listen: false),
          title: 'Ramen',
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: Center(
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
        ));
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

    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      bool isFinding = state.status == HomeStatus.Finding;
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
              HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
              switch (state.status) {
                case HomeStatus.Finding:
                  homeCubit.cancelFind();
                  break;
                case HomeStatus.Idle:
                  homeCubit.find();
                  break;
                default:
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
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      bool isFinding = state.status == HomeStatus.Finding;
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
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      bool isFinding = state.status == HomeStatus.Finding;
      return Text(
        isFinding ? "Finding a partner..." : "Welcome to Ramen!",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headline1?.color),
      );
    });
  }
}

class _Tooltip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      bool isFinding = state.status == HomeStatus.Finding;
      return Text(
        isFinding
            ? "Click a button to cancel"
            : "Only 30 seconds for a conversation.",
        style: TextStyle(
          fontSize: 17,
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
      );
    });
  }
}
