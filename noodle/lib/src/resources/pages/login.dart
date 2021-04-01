import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset('assets/images/logo.png'),
                    Text('Login to your account', style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(
                      height: 15,
                    ),
                    buildTextField("Username or Email Address"),
                    buildTextField("Password"),
                    SizedBox(
                      height: 15,
                    ),
                    buildSubmitButton(Container(
                      margin: EdgeInsets.symmetric(vertical: 13),
                      child: Text("Log In",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor)),
                    ))
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 40))));
  }

  Widget buildTextField(String hintText) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextField(
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

  Widget buildSubmitButton(Widget content) {
    return RaisedButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Theme.of(context).primaryColor,
      child: content,
      elevation: 0.0,
    );
  }
}
