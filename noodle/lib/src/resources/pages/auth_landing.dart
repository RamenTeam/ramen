import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noodle/src/constants/mock/User.entity.dart';
import 'package:noodle/src/utils/route_builder.dart';

class AuthLanding extends StatefulWidget {
  AuthLanding({Key key})
      : super(key: key);

  @override
  _AuthLandingState createState() => _AuthLandingState();
}

class _AuthLandingState extends State<AuthLanding> {
  void fetchUserData() async {
    // Do some API calls during loading state
    print("Fetching user data");
    MockUser currentUser = await Future.delayed(Duration(seconds: 1), () {
      return null;
    });
    if (currentUser != null) {
      Navigator.pushNamed(context, "/");
    } else {
      Navigator.pushNamed(context, "/login");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange[50],
        body: Center(
          child: SpinKitWave(
            color: Colors.orange,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
