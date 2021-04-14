import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_event.dart';
import 'package:noodle/src/resources/pages/auth/local_build/build_divider.dart';
import 'package:noodle/src/resources/pages/auth/local_build/build_text_field.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/form_input/email_input.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/form_input/password_input.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/social_submit_button.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/submit_button.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
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
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              EmailInput(),
              PasswordInput(),
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
                  onPressCallback: () {}),
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
                          ..onTap = () {
                            Provider.of<LoginNavigationBloc>(
                              context,
                              listen: false,
                            ).add(NavigateToRegister());
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 40),
        ),
      ),
    );
  }
}
