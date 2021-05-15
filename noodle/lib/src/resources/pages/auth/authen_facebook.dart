import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:noodle/src/resources/pages/login/login.dart';
//import 'package:noodle/src/resources/pages/home/home.dart';

class FacebookAuthenRoute extends StatefulWidget {
  @override
  _FacebookAuthenRouteState createState() => _FacebookAuthenRouteState();
}

class _FacebookAuthenRouteState extends State<FacebookAuthenRoute> {
  final _auth = FirebaseAuth.instance;
  final _facebookLogin = FacebookLogin();
  bool _isLoggedIn = false;
  String _message = "";

  // Function to handle log in
  Future _loginWithFacebook() async {
    final result = await _facebookLogin.logIn(['email']);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token,
      );
      // Obtain user credential
      final user = (await _auth.signInWithCredential(credential)).user;
      setState(() {
        _message = "Logged in as ${user.displayName}";
        _isLoggedIn = true;
      });
      // For debugging only - Print the user's data to console
      // TODO [Tra Nguyen] SNS Sign in - Save user info into database - Change app route to AuthLanding() to test
      log('[Tra Nguyen] User info = [Name: ${user.displayName}, Email: ${user.email}]');
    }
  }

  // Function to handle log out
  Future _logout() async {
    await _auth.signOut();
    await _facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
      // For debugging only
      log('Logged out successfully!');
      // Redirect back to log in screen once user is signed out
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  // Check if the user is logged in
  Future _checkLoginStatus() async {
    final user = await _auth.currentUser();
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
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: () {
                  _loginWithFacebook();
                },
                style: ElevatedButton.styleFrom(primary: Colors.yellow),
                child: Text('Tap to continue with Facebook',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
      ),
    );
  }
}
