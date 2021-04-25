import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotificationDemo extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PushNotification(),
    );
  }
}
class PushNotification extends StatefulWidget {
  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  final Firestore _fdb = Firestore.instance; // database to save device token
  final FirebaseMessaging _fcm = FirebaseMessaging();

  // SENDING NOTIFICATION
  // Type 1: Single device notification
  // TODO
//  _saveToken() async {
//    // Once user has signed in, obtain device token and save it to database
//    // String uid = $userid;
//    // FirebaseUser user = await _auth.currentUser();  // uncomment this
//    String fcmToken = await _fcm.getToken();
//    if (fcmToken != null) {
//      var tokens = _fdb
//          .collection('users')
//          .document(uid)
//          .collection('tokens')
//          .document(fcmToken);
//
//      await tokens.setData({
//        'token': fcmToken
//      });
//    }
//  }
  // Type 2: User segment notification
  // Go to Firebase Console to create user segment and send notification
  // TODO Confirm if this type of notification is necessary

  // Type 3: Topic subscription notification
  // Send notification to user based on subscribed topics
  // TODO Confirm if this type of notification is necessary

  // RECEIVING NOTIFICATION
  // Callback functions to handle the incoming notification
  @override
  void initState() {
    _fcm.configure(
      // onMessage is executed when the app is open and running in foreground
      // Display a dialog pop up that contains message of the notification
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
        );
      },
      // onLaunch is executed when the app is closed
      // By default, display notification on the device's slide down
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      // onResume is executed when the app is running in the background
      // By default, display notification on the device's slide down
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      // TODO Handle click event and navigate to certain screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}