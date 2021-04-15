import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_event.dart';
import 'package:noodle/src/core/bloc/register/register_cubit.dart';
import 'package:noodle/src/core/bloc/register/register_state.dart';
import 'package:noodle/src/resources/pages/auth/local_build/build_divider.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/form_input.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/social_submit_button.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:formz/formz.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Padding(
          child: ListView(
            children: [
              // Image.asset(
              //   'assets/images/logo.png',
              //   height: 150,
              // ),
              SizedBox(height: 25),
              Text(
                'Sign up with Ramen',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline1?.color),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: _FirstNameInput()),
                  SizedBox(width: 10),
                  Flexible(child: _LastNameInput()),
                ],
              ),
              _RegisterSuccessListener(),
              _UsernameInput(),
              _EmailInput(),
              _PhoneNumberInput(),
              _PasswordInput(),
              _ConfirmedPasswordInput(),
              _RegisterErrorText(),
              SizedBox(height: 20),
              _RegisterButton(),
              SizedBox(height: 20),
              buildDivider(text: "Created with", context: context),
              SizedBox(height: 20),
              SocialSubmitButton(
                  text: "Sign up with Facebook",
                  color: HexColor("#3b5999"),
                  icon: FaIcon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                    size: 14,
                  ),
                  onPressCallback: () {}),
              SizedBox(height: 4),
              SocialSubmitButton(
                  text: "Sign up with Google",
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
                        text: 'Already have an account?',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.headline1?.color),
                      ),
                      TextSpan(
                          text: ' Login here!',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1?.color,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Provider.of<LoginNavigationBloc>(
                                context,
                                listen: false,
                              ).add(NavigateToLogin());
                            }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 40),
        ),
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.only(
                bottom:
                    state.firstName.invalid || state.lastName.invalid ? 10 : 0),
            child: FormInput(
                onChangedCallback: (value) => Provider.of<RegisterCubit>(
                      context,
                      listen: false,
                    ).firstNameChanged(value),
                labelText: 'First name',
                errorText: state.firstName.invalid ? 'Invalid name' : null,
                inputKey: 'registerForm_firstNameInput_textField'));
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.only(
                bottom:
                    state.firstName.invalid || state.lastName.invalid ? 10 : 0),
            child: FormInput(
                onChangedCallback: (value) =>
                    Provider.of<RegisterCubit>(context, listen: false)
                        .lastNameChanged(value),
                labelText: 'Last name',
                errorText: state.lastName.invalid ? 'Invalid name' : null,
                inputKey: 'registerForm_lastNameInput_textField'));
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.only(bottom: state.username.invalid ? 10 : 0),
            child: FormInput(
                onChangedCallback: (value) => Provider.of<RegisterCubit>(
                      context,
                      listen: false,
                    ).usernameChanged(value),
                labelText: "Username",
                errorText: state.username.invalid ? "Invalid username" : null,
                inputKey: "'registerForm_usernameInput_textField'"));
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.only(bottom: state.email.invalid ? 10 : 0),
            child: FormInput(
                onChangedCallback: (value) => Provider.of<RegisterCubit>(
                      context,
                      listen: false,
                    ).emailChanged(value),
                labelText: 'Email',
                errorText: state.email.invalid ? 'Invalid email' : null,
                inputKey: 'registerForm_emailInput_textField'));
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.only(bottom: state.phoneNumber.invalid ? 10 : 0),
            child: FormInput(
                onChangedCallback: (value) => Provider.of<RegisterCubit>(
                      context,
                      listen: false,
                    ).phoneNumberChanged(value),
                labelText: 'Phone number',
                errorText:
                    state.phoneNumber.invalid ? 'Invalid phone number' : null,
                inputKey: 'registerForm_phoneNumberInput_textField'));
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.only(bottom: state.password.invalid ? 10 : 0),
            child: FormInput(
                isObscured: true,
                onChangedCallback: (value) => Provider.of<RegisterCubit>(
                      context,
                      listen: false,
                    ).passwordChanged(value),
                labelText: 'Password',
                errorText: state.password.invalid
                    ? 'Password must have at least 6 characters'
                    : null,
                inputKey: 'registerForm_passwordInput_textField'));
      },
    );
  }
}

class _ConfirmedPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return FormInput(
            isObscured: true,
            onChangedCallback: (value) =>
                Provider.of<RegisterCubit>(context, listen: false)
                    .confirmedPasswordChanged(value),
            labelText: 'Confirmed password',
            errorText: state.confirmedPassword.invalid
                ? 'Passwords do not match'
                : null,
            inputKey: 'registerForm_confirmedPasswordInput_textField');
      },
    );
  }
}

class _RegisterErrorText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
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

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return SubmitButton(
              content: Container(
                key: const Key('registerForm_submitButton'),
                margin: EdgeInsets.symmetric(vertical: 13),
                child: Text("Register",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor)),
              ),
              color: Theme.of(context).primaryColor,
              onPressCallback: () {
                if (state.status.isValidated) {
                  print("register valid");
                  Provider.of<RegisterCubit>(context, listen: false).register();
                }
              });
        });
  }
}

class _RegisterSuccessListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Register account successfully!"),
            backgroundColor: Colors.green,
          ));
        }
      },
      child: Container(),
    );
  }
}
