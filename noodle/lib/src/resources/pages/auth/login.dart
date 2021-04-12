import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:noodle/src/constants/api_endpoint.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_event.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_event.dart';
import 'package:noodle/src/core/models/authentication_status.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';
import 'package:noodle/src/resources/pages/auth/local_build/build_text_field.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/social_submit_button.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/submit_button.dart';
import 'package:noodle/src/resources/pages/auth/register.dart';
import 'package:noodle/src/resources/pages/navigation/home_navigation.dart';
import 'package:noodle/src/utils/route_builder.dart';
import 'package:provider/provider.dart';

import 'local_build/build_divider.dart';

class LoginScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

///FIXME Layout overflow while click on the input field to enter info
///
///#1 - Known issues:
///-> Add the social button
///-> Add API implementation
///

///@chungquantin
class _LoginScreenState extends State<LoginScreen> {
  ///@khaitruong922
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String loginMessage = "";
  Color loginMessageColor = Colors.red;

  Future<void> login() async {
    String username = usernameController.text;
    String password = passwordController.text;
    RamenApiResponse? res =
        await context.read<AuthenticationBloc>().logInWithEmailAndPassword(
              email: username,
              password: password,
            );

    if (res == null) {
      Provider.of<AuthenticationBloc>(context, listen: false)
          .add(AuthenticationStatusChanged(AuthenticationStatus.AUTHENTICATED));
      return;
    }
    setErrorMessage(res.message);
  }

  void setErrorMessage(String message) {
    setState(() {
      loginMessage = message;
      loginMessageColor = Colors.red;
    });
  }

  void setSuccessMessage(String message) {
    setState(() {
      loginMessage = message;
      loginMessageColor = Colors.green;
    });
  }

  void navigateToRegister() {
    Provider.of<LoginNavigationBloc>(context, listen: false)
        .add(NavigateToRegister());
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Image.asset(
                    //   'assets/images/logo.png',
                    //   height: 150,
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Login your account',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    buildTextField(
                        hintText: "Username or Email Address",
                        controller: usernameController),
                    buildTextField(
                        hintText: "Password", controller: passwordController),
                    SizedBox(
                      height: 15,
                    ),
                    buildLoginMessageText(),
                    SizedBox(
                      height: 15,
                    ),
                    SubmitButton(
                        content: Container(
                          margin: EdgeInsets.symmetric(vertical: 13),
                          child: Text("Sign In",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor)),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressCallback: login),
                    SizedBox(height: 20),
                    buildDivider(text: "or"),
                    SizedBox(height: 20),
                    SocialSubmitButton(
                        text: "Sign in with Facebook",
                        color: HexColor("#3b5999"),
                        icon: FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
                          size: 14,
                        ),
                        onPressCallback: () {}),
                    SizedBox(height: 4),
                    SocialSubmitButton(
                        text: "Sign in with Google",
                        color: HexColor("#dd4b39"),
                        icon: FaIcon(FontAwesomeIcons.google,
                            color: Colors.white, size: 14),
                        onPressCallback: () {}),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Register now!',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = navigateToRegister,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 40))));
  }

  Widget buildLoginMessageText() {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      visible: loginMessage != "",
      child: Text(
        loginMessage,
        style: TextStyle(
          fontSize: 14,
          color: loginMessageColor,
        ),
      ),
    );
  }
}
