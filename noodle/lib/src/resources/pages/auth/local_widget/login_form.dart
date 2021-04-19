import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_event.dart';
import 'package:noodle/src/core/bloc/login/login_cubit.dart';
import 'package:noodle/src/core/bloc/login/login_state.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_event.dart';
import 'package:noodle/src/core/models/authentication_status.dart';
import 'package:noodle/src/resources/pages/auth/local_build/build_divider.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/social_submit_button.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:noodle/src/resources/pages/auth/authen_facebook.dart';
import 'package:noodle/src/resources/pages/auth/authen_google.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Padding(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image.asset(
              //   'assets/images/logo.png',
              //   height: 150,
              // ),
              SizedBox(height: 25),
              Text(
                'Login to your account',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline1?.color),
              ),
              SizedBox(height: 15),
              _LoginSuccessListener(),
              _EmailInput(),
              _PasswordInput(),
              _LoginErrorText(),
              _SignInButton(),
              SizedBox(height: 20),
              buildDivider(text: "or", context: context),
              SizedBox(height: 20),
              SocialSubmitButton(
                text: "Sign in with Facebook",
                color: HexColor("#3b5999"),
                icon: FaIcon(
                  FontAwesomeIcons.facebookF,
                  color: Colors.white,
                  size: 14,
                ),
                onPressCallback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FacebookAuthenRoute()),
                  );
                },
              ),
              SizedBox(height: 4),
              SocialSubmitButton(
                  text: "Sign in with Google",
                  color: HexColor("#dd4b39"),
                  icon: FaIcon(FontAwesomeIcons.google,
                      color: Colors.white, size: 14),
                  onPressCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GoogleAuthenRoute()),
                    );
                  }),
              SizedBox(
                height: 15,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.headline1?.color),
                      ),
                      TextSpan(
                        text: 'Register now!',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline1?.color,
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.only(bottom: state.email.invalid ? 10 : 0),
            child: TextField(
              key: const Key('loginForm_emailInput_textField'),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline1?.color,
              ),
              onChanged: (value) => Provider.of<LoginCubit>(
                context,
                listen: false,
              ).emailChanged(value),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Theme.of(context).highlightColor),
                helperText: '',
                focusColor: Theme.of(context).textTheme.headline1?.color,
                errorText: state.email.invalid ? 'Invalid email' : null,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).highlightColor, width: 0.6),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ));
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1?.color,
          ),
          onChanged: (value) => Provider.of<LoginCubit>(
            context,
            listen: false,
          ).passwordChanged(value),
          obscureText: true,
          decoration: InputDecoration(
            focusColor: Theme.of(context).textTheme.headline1?.color,
            labelText: 'Password',
            labelStyle: TextStyle(color: Theme.of(context).highlightColor),
            helperText: '',
            errorText: state.password.invalid ? 'Invalid password' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).highlightColor, width: 0.6),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return SubmitButton(
              content: Container(
                key: const Key('loginForm_submitButton'),
                margin: EdgeInsets.symmetric(vertical: 13),
                child: Text("Login",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor)),
              ),
              color: Theme.of(context).primaryColor,
              onPressCallback: () {
                if (state.status.isValidated) {
                  print("login valid");
                  Provider.of<LoginCubit>(context, listen: false)
                      .logInWithEmailAndPassword();
                }
              });
        });
  }
}

class _LoginErrorText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Visibility(
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        visible: state.status.isSubmissionSuccess ||
            state.status.isSubmissionFailure,
        child: Text(
          state.responseMessage,
          style: TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        ),
      );
    });
  }
}

class _LoginSuccessListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.success) {
          Provider.of<AuthenticationBloc>(context, listen: false).add(
              AuthenticationStatusChanged(AuthenticationStatus.AUTHENTICATED));
        }
      },
      child: Container(),
    );
  }
}
