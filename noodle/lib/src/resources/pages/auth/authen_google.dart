import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noodle/src/resources/pages/login/login.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ],
);

class GoogleAuthenRoute extends StatefulWidget {
  @override
  _GoogleAuthenRouteState createState() => _GoogleAuthenRouteState();
}

class _GoogleAuthenRouteState extends State<GoogleAuthenRoute> {
  GoogleSignInAccount? _currentUser;
  String _message = '';
  bool _isLoggedIn = false;

  Future _loginWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      GoogleSignInAccount? user = _currentUser;
      if (user != null) {
        log("User info: Name - ${user.displayName}, Email - ${user.email}");
        setState(() {
          _message = "Logged in as ${user.displayName}";
          _isLoggedIn = true;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Future _logout() async {
    _googleSignIn.disconnect();
    // For debugging only
    log('Logged out successfully! Redirecting user to log in screen');
    // Redirect back to log in screen once user is signed out
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  // Check if the user is logged in
  Future _checkLoginStatus() async {
    await _googleSignIn.signIn();
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      setState(() {
        _message = "Logged in as ${user.displayName}";
        _isLoggedIn = true;
        // Redirect to home page once user is logged in
        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: _isLoggedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(_message,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 12.0),
                    ElevatedButton(
                      onPressed: () {
                        _logout();
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.yellow),
                      child: Text('Logout',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    _loginWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.yellow),
                  child: Text('Tap to continue with Google',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
        ));
  }
}
