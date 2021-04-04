import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:noodle/src/constants/api_endpoint.dart';
import 'package:noodle/src/resources/pages/login/login.dart';
import 'package:noodle/src/utils/route_builder.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ///@khaitruong922
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> register() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    if (password != confirmPassword) {
      // Display error message
      return;
    }

    http.Response res = await http.post(
      Uri.https(ApiEndpoint.authority, ApiEndpoint.register),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email,
        'phone': phone,
      }),
    );
    print(res.body);
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      SlideRoute(
        page: LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    phoneController.dispose();
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
                    buildTextField(
                      "Username",
                      controller: usernameController,
                    ),
                    buildTextField(
                      "Email address",
                      controller: emailController,
                    ),
                    buildTextField(
                      "Phone number",
                      controller: phoneController,
                    ),
                    buildTextField(
                      "Password",
                      controller: passwordController,
                    ),
                    buildTextField("Confirm password",
                        controller: confirmPasswordController),
                    SizedBox(
                      height: 15,
                    ),
                    buildSubmitButton(
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 13),
                          child: Text("Sign Up",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor)),
                        ),
                        Theme.of(context).primaryColor,
                        register),
                    SizedBox(height: 20),
                    buildDivider(),
                    SizedBox(height: 20),
                    buildSocialButton(
                        "Facebook",
                        HexColor("#3b5999"),
                        FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
                          size: 14,
                        ),
                        () {}),
                    SizedBox(height: 4),
                    buildSocialButton(
                        "Google",
                        HexColor("#dd4b39"),
                        FaIcon(FontAwesomeIcons.google,
                            color: Colors.white, size: 14),
                        () {}),
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

  Widget buildTextField(String hintText, {TextEditingController controller}) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Colors.grey, width: 0.3),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: hintText),
        ));
  }

  Widget buildDivider() {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        height: 2,
        thickness: 1,
        color: Colors.black.withOpacity(0.3),
      )),
      SizedBox(width: 20),
      Text("or"),
      SizedBox(width: 20),
      Expanded(
          child: Divider(
        height: 2,
        thickness: 1,
        color: Colors.black.withOpacity(0.3),
      )),
    ]);
  }

  Widget buildSubmitButton(
      Widget content, Color color, Function onPressCallback) {
    return ElevatedButton(
      onPressed: onPressCallback,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )),
        backgroundColor: MaterialStateProperty.all(color),
      ),
      child: content,
    );
  }

  Widget buildSocialButton(
      String media, Color color, Widget icon, Function onPressCallback) {
    return buildSubmitButton(
        Container(
          margin: EdgeInsets.symmetric(vertical: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              SizedBox(width: 15),
              Text("Sign up with $media",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor))
            ],
          ),
        ),
        color,
        onPressCallback);
  }
}
