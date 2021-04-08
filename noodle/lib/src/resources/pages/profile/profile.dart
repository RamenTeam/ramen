import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfileScreen());
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    Widget buildInfoHeader() {
      return ListTile(
        leading: FlutterLogo(),
        title: Text(
          'John Doe',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('One-line with leading widget'),
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
                      side:
                          BorderSide(color: Theme.of(context).primaryColor)))),
        ),
      );
    }

    Widget buildInfoSection() {
      return Container(
          margin: EdgeInsets.only(top: screenSize.height / 2.2),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: ListView(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  buildInfoHeader(),
                  Container(
                    child: ListTile(
                      title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Bio",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          )),
                      subtitle: Text(
                        "The overflow property's behavior is affected by the softWrap argument. "
                        "If the softWrap is true or null, the glyph causing overflow, and those that follow, "
                        "will not be rendered. Otherwise, it will be shown with the given overflow option.",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: ListTile(
                          title: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Hoobies",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          subtitle: TextFieldTags(
                              tagsStyler: TagsStyler(
                                tagTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                tagDecoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                tagCancelIcon: Icon(Icons.cancel,
                                    size: 16.0, color: Colors.white),
                                tagPadding: const EdgeInsets.all(10.0),
                              ),
                              textFieldStyler: TextFieldStyler(),
                              onTag: (tag) {},
                              onDelete: (tag) {})),
                    ),
                  ),
                ],
              )));
    }

    return Scaffold(
        body: Stack(
      children: [
        Container(
            child: Container(
          child: Image.network(
              "https://pbs.twimg.com/profile_images/1349755150316040194/VpUCtbH8_400x400.jpg"),
        )),
        buildInfoSection()
      ],
    ));
  }
}
