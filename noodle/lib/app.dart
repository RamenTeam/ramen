import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/landing/auth_landing.dart';
import 'package:flutter/material.dart';
// import 'package:noodle/src/resources/theme/theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:hexcolor/hexcolor.dart';

class RamenApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  RamenApp(
      {Key? key,
      required this.authenticationRepository,
      required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        title: "Ramen",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: HexColor("FCBF30"),
            accentColor: HexColor("121212"),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor("121212"),
                selectedItemColor: HexColor("FCBF30"),
                unselectedItemColor: Colors.grey),
            appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            textTheme: TextTheme(
                headline1: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                headline2: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
                headline3: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                bodyText1: TextStyle(
                    color: Colors.white.withAlpha(150),
                    fontWeight: FontWeight.w400))),
        home: BlocProvider(
            create: (_) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                  userRepository: userRepository,
                ),
            child: AuthLanding()));
  }
}
