import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneVerificationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhoneVerificationPage(),
    );
  }
}

class PhoneVerificationPage extends StatefulWidget {
  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId = "";

  // Functions to handle phone number verification
  Future verifyPhoneNumber() async {
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken = 12]) async {
      _verificationId = verificationId;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text('Code sent!'),
            subtitle: Text('Check your message for verification code'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text('Code expired'),
            subtitle: Text('Please request for another code'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        timeout: const Duration(seconds: 90),
        verificationCompleted: null,
        verificationFailed: null,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Function to handle code validation
  Future validateCode() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _smsController.text);
    // check if sms code is correct
    try {
      _auth.signInWithCredential(credential);
      // TODO Save user's phone number to database
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text('Verification completed!'),
            subtitle: Text('Your phone has been registered successfully'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text('Verification failed!'),
            subtitle: Text('Unable to verify number. Please try again.'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Phone number input form
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                        labelText: 'Phone number (+84 xxx-xxx-xxxx)'),
                  ),
                  // Submit phone number button
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.yellow),
                      child: Text("Get code"),
                      onPressed: () async {
                        verifyPhoneNumber();
                      },
                      // display pop up dialog
                    ),
                  ),

                  // Verification code input form
                  TextFormField(
                    controller: _smsController,
                    decoration:
                        const InputDecoration(labelText: 'Verification code'),
                  ),

                  // Submit verification code button
                  Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.yellow),
                        onPressed: () async {
                          validateCode();
                          // save number to database and navigate user to user page
                        },
                        child: Text("Submit code")),
                  ),
                ],
              )),
        ));
  }
}
