import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:noodle/src/constants/api_endpoint.dart';
import 'package:noodle/src/models/ramen_api_response.dart';
import 'package:noodle/src/resources/pages/register/register.dart';
import 'package:noodle/src/utils/route_builder.dart';

class LoginScreen extends StatefulWidget {
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
    http.Response res = await http.post(
      Uri.https(ApiEndpoint.authority, ApiEndpoint.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'data': {
          'email': username,
          'password': password,
        },
      }),
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      // Register account successfully
      if (json == null) {
        print("Login sucessfully!");
        setState(() {
          loginMessage = "Login successfully!";
          loginMessageColor = Colors.green;
        });
      } else {
        RamenApiResponse ramenApiResponse = RamenApiResponse.fromJson(json);
        setState(() {
          loginMessage = ramenApiResponse.message;
          loginMessageColor = Colors.red;
        });
      }
    } else {
      print("API error");
    }
  }

  void navigateToRegister() {
    Navigator.pushReplacement(
      context,
      SlideRoute(
        page: RegisterScreen(),
      ),
    );
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
                    buildTextField("Username or Email Address",
                        controller: usernameController),
                    buildTextField("Password", controller: passwordController),
                    SizedBox(
                      height: 15,
                    ),
                    buildLoginMessageText(),
                    SizedBox(
                      height: 15,
                    ),
                    buildSubmitButton(
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 13),
                          child: Text("Sign In",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor)),
                        ),
                        Theme.of(context).primaryColor,
                        login),
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
              Text("Sign in with $media",
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
