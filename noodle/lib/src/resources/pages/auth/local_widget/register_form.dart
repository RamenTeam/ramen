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
import 'package:noodle/src/resources/pages/auth/local_widget/social_submit_button.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:formz/formz.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Sign up with Ramen',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
              _RegisterButton(),
              SizedBox(height: 20),
              buildDivider(text: "Created with"),
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
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                          text: 'Login here!',
                          style: TextStyle(
                            color: Colors.black,
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
        return TextField(
          key: const Key('registerForm_firstNameInput_textField'),
          onChanged: (value) => Provider.of<RegisterCubit>(
            context,
            listen: false,
          ).firstNameChanged(value),
          decoration: InputDecoration(
            labelText: 'First name',
            helperText: '',
            errorText: state.firstName.invalid ? 'Invalid name' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.3),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        return TextField(
          key: const Key('registerForm_lastNameInput_textField'),
          onChanged: (value) => Provider.of<RegisterCubit>(
            context,
            listen: false,
          ).lastNameChanged(value),
          decoration: InputDecoration(
            labelText: 'Last name',
            helperText: '',
            errorText: state.lastName.invalid ? 'Invalid name' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.3),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        return TextField(
          key: const Key('registerForm_usernameInput_textField'),
          onChanged: (value) => Provider.of<RegisterCubit>(
            context,
            listen: false,
          ).usernameChanged(value),
          decoration: InputDecoration(
            labelText: 'Username',
            helperText: '',
            errorText: state.username.invalid ? 'Invalid username' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.3),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        return TextField(
          key: const Key('registerForm_emailInput_textField'),
          onChanged: (value) => Provider.of<RegisterCubit>(
            context,
            listen: false,
          ).emailChanged(value),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: state.email.invalid ? 'Invalid email' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.3),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        return TextField(
          key: const Key('registerForm_phoneNumberInput_textField'),
          onChanged: (value) => Provider.of<RegisterCubit>(
            context,
            listen: false,
          ).phoneNumberChanged(value),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Phone number',
            helperText: '',
            errorText:
                state.phoneNumber.invalid ? 'Invalid phone number' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.3),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        return TextField(
          key: const Key('registerForm_passwordInput_textField'),
          onChanged: (value) => Provider.of<RegisterCubit>(
            context,
            listen: false,
          ).passwordChanged(value),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'Invalid password' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.3),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
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
        return TextField(
          key: const Key('registerForm_confirmedPasswordInput_textField'),
          onChanged: (value) => Provider.of<RegisterCubit>(
            context,
            listen: false,
          ).confirmedPasswordChanged(value),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirmed password',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'Passwords do not match'
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.3),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
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
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Register account successfully!")));
        }
      },
      child: Container(),
    );
  }
}
