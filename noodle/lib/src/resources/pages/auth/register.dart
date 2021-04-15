import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/login_navigation/login_navigation_event.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/resources/pages/auth/local_build/build_divider.dart';
import 'package:noodle/src/resources/pages/auth/local_build/build_text_field.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/social_submit_button.dart';
import 'package:noodle/src/resources/pages/auth/local_widget/submit_button.dart';
import 'package:noodle/src/core/repositories/authentication_repository.dart';

class RegisterScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterScreen());
  }

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final authRepo = AuthenticationRepository();
  String registerMessage = "";
  Color registerMessageColor = Colors.red;

  Future<void> register() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String email = emailController.text;
    String phoneNumber = phoneNumberController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    RamenApiResponse? res =
        await Provider.of<AuthenticationBloc>(context, listen: false).register(
      username: username,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
    );
    if (res == null) {
      // Todo: Change to snackbar
      setSuccessMessage("Register account successfully!");
      return;
    }
    setErrorMessage(res.message);
  }

  void setErrorMessage(String message) {
    setState(() {
      registerMessage = message;
      registerMessageColor = Colors.red;
    });
  }

  void setSuccessMessage(String message) {
    setState(() {
      registerMessage = message;
      registerMessageColor = Colors.green;
    });
  }

  void navigateToLogin() {
    Provider.of<LoginNavigationBloc>(context, listen: false)
        .add(NavigateToLogin());
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    authRepo.dispose();
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
                  children: [
                    // Image.asset(
                    //   'assets/images/logo.png',
                    //   height: 150,
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Sign up with Ramen',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: buildTextField(
                            hintText: "First name",
                            controller: firstNameController,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: buildTextField(
                            hintText: "Last name",
                            controller: lastNameController,
                          ),
                        ),
                      ],
                    ),

                    buildTextField(
                      hintText: "Username",
                      controller: usernameController,
                    ),
                    buildTextField(
                      hintText: "Email address",
                      controller: emailController,
                    ),
                    buildTextField(
                      hintText: "Phone number",
                      controller: phoneNumberController,
                    ),
                    buildTextField(
                      hintText: "Password",
                      controller: passwordController,
                    ),
                    buildTextField(
                        hintText: "Confirm password",
                        controller: confirmPasswordController),
                    SizedBox(
                      height: 15,
                    ),
                    buildRegisterMessageText(),
                    SizedBox(
                      height: 15,
                    ),
                    SubmitButton(
                        content: Container(
                          margin: EdgeInsets.symmetric(vertical: 13),
                          child: Text("Sign Up",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor)),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressCallback: register),
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
                                ..onTap = navigateToLogin,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 40))));
  }

  Widget buildRegisterMessageText() {
    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      visible: registerMessage != "",
      child: Text(
        registerMessage,
        style: TextStyle(
          fontSize: 14,
          color: registerMessageColor,
        ),
      ),
    );
  }
}
