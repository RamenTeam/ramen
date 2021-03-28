import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void findPartner() {
    print("Finding partner");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow)),
            child: Text(
              "Find a partner",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: findPartner,
          )
        ],
      ),
    );
  }
}
