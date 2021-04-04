import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

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

  Future<void> login() async {
    print(usernameController.text);
    print(passwordController.text);
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
                      'Login to your account',
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
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Register Now!',
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
