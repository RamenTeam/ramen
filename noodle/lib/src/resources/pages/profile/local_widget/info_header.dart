import 'package:flutter/material.dart';

class ProfileInfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FlutterLogo(),
      title: Text(
        'John Doe',
        style: Theme.of(context).textTheme.headline1,
      ),
      subtitle: Text(
        'One-line with leading widget',
        style: Theme.of(context).textTheme.headline2,
      ),
      trailing: ElevatedButton(
        onPressed: () {},
        child: Text("Connect", style: TextStyle(fontWeight: FontWeight.bold)),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0.0),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Theme.of(context).primaryColor)))),
      ),
    );
  }
}
