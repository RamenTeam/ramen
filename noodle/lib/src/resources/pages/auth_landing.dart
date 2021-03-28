import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noodle/src/constants/mock/User.entity.dart';
import 'package:noodle/src/utils/route_builder.dart';

class AuthLanding extends StatefulWidget {
  final Widget redirectedPage;
  AuthLanding({Key key, this.redirectedPage}) : super(key: key);

  @override
  _AuthLandingState createState() => _AuthLandingState();
}

class _AuthLandingState extends State<AuthLanding> {
  void fetchUserData() async {
    // Do some API calls during loading state
    print("Fetching user data");
    MockUser currentUser = await Future.delayed(Duration(seconds: 3), () {
      return MockUser(username: "khaitruong922");
    });
    if (currentUser != null) {
      Navigator.pushReplacement(
          context, FadeRoute(page: widget.redirectedPage));
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
