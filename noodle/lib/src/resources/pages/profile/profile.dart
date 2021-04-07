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
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 232, 124, 1),
      body: Column(children: [
        Row(
          // Row 1 - Profile Photo
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 25.0, bottom: 15.0),
              child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://cdn3.vectorstock.com/i/1000x1000/30/97/flat-business-man-user-profile-avatar-icon-vector-4333097.jpg'
                        ),
                        radius: 70.0,
                      ),
                      SizedBox(height: 10.0),  // in place of padding
                      Text(
                        'John Doe',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
        Row(
          // Row 2 - Biography
          children: [
            Container(
              child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ListTile(

                      title: Text("Bio",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("The overflow property's behavior is affected by the softWrap argument. "
                          "If the softWrap is true or null, the glyph causing overflow, and those that follow, "
                          "will not be rendered. Otherwise, it will be shown with the given overflow option.",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
        Row(
          // Row 3 - Hobbies
          children: [
            Container(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: ListTile(
                      title: Text("Hoobies",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle:
                      TextFieldTags(
                          tagsStyler: TagsStyler(
                            tagTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            tagDecoration: BoxDecoration(color: Colors.amberAccent, borderRadius: BorderRadius.circular(8.0),
                            ),
                            tagCancelIcon: Icon(Icons.cancel, size: 16.0, color: Colors.white),
                            tagPadding: const EdgeInsets.all(10.0),
                          ),
                          textFieldStyler: TextFieldStyler(),
                          onTag: (tag) {},
                          onDelete: (tag) {}
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          // Row 4 - Location
          children: [
            Container(
              child: Expanded(
                child: ListTile(
                  title: Text("Location",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: ListTile(
                  title: Text("Ho Chi Minh, Vietnam"),
                ),
              ),
            ),
          ],
        ),
        Row(
          // Row 5 - Email
          children: [
            Container(
              child: Expanded(
                child: ListTile(
                  title: Text("Email",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: ListTile(
                  title: Text("johndoe@hotmail.com"),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // Row 6 - Settings & sign out buttons
          children: [
            Container(
              child: ElevatedButton(
                child: Text(
                  "Settings",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 20.0),  // in place of padding
            Container(
              child: ElevatedButton(
                child: Text(
                    "Sign out",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
      ),
    );
  }
}
