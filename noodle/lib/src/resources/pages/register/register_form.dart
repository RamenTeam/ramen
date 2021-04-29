import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:noodle/src/resources/login_navigation/bloc/login_navigation_bloc.dart';
import 'package:noodle/src/resources/login_navigation/bloc/login_navigation_event.dart';
import 'package:noodle/src/resources/pages/register/bloc/register_cubit.dart';
import 'package:noodle/src/resources/pages/register/bloc/register_state.dart';
import 'package:noodle/src/resources/shared/build_divider.dart';
import 'package:noodle/src/resources/shared/form_input.dart';
import 'package:noodle/src/resources/shared/social_submit_button.dart';
import 'package:noodle/src/resources/shared/submit_button.dart';
import 'package:provider/provider.dart';

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
              SizedBox(height: 10),
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
          margin: EdgeInsets.only(bottom: 10),
          child: FormInput(
            onChangedCallback: (value) => Provider.of<RegisterCubit>(
              context,
              listen: false,
            ).firstNameChanged(value),
            labelText: 'First name',
            errorText: state.firstName.invalid ? 'Invalid name' : null,
          ),
        );
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
          margin: EdgeInsets.only(bottom: 10),
          child: FormInput(
            onChangedCallback: (value) =>
                Provider.of<RegisterCubit>(context, listen: false)
                    .lastNameChanged(value),
            labelText: 'Last name',
            errorText: state.lastName.invalid ? 'Invalid name' : null,
          ),
        );
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
          margin: EdgeInsets.only(bottom: 10),
          child: FormInput(
            onChangedCallback: (value) => Provider.of<RegisterCubit>(
              context,
              listen: false,
            ).usernameChanged(value),
            labelText: "Username",
            errorText: state.username.invalid ? "Invalid username" : null,
          ),
        );
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
          margin: EdgeInsets.only(bottom: 10),
          child: FormInput(
            textInputType: TextInputType.emailAddress,
            onChangedCallback: (value) => Provider.of<RegisterCubit>(
              context,
              listen: false,
            ).emailChanged(value),
            labelText: 'Email',
            errorText: state.email.invalid ? 'Invalid email' : null,
          ),
        );
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
          margin: EdgeInsets.only(bottom: 10),
          child: FormInput(
            textInputType: TextInputType.phone,
            onChangedCallback: (value) => Provider.of<RegisterCubit>(
              context,
              listen: false,
            ).phoneNumberChanged(value),
            labelText: 'Phone number',
            errorText:
                state.phoneNumber.invalid ? 'Invalid phone number' : null,
          ),
        );
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
          margin: EdgeInsets.only(bottom: 10),
          child: FormInput(
              obscureText: true,
              onChangedCallback: (value) => Provider.of<RegisterCubit>(
                    context,
                    listen: false,
                  ).passwordChanged(value),
              labelText: 'Password',
              errorText: state.password.invalid
                  ? 'Password must have at least 6 characters'
                  : null),
        );
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
          obscureText: true,
          onChangedCallback: (value) =>
              Provider.of<RegisterCubit>(context, listen: false)
                  .confirmedPasswordChanged(value),
          labelText: 'Confirmed password',
          errorText:
              state.confirmedPassword.invalid ? 'Passwords do not match' : null,
        );
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
