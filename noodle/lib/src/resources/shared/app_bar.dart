import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/resources/pages/setting/setting.dart';

class SharedAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String title;

  SharedAppBar({required this.title});

  @override
  _SharedAppBarState createState() => _SharedAppBarState();
}

class _SharedAppBarState extends State<SharedAppBar> {
  String userAvatarPath =
      "https://xaydunghoanghung.com/wp-content/uploads/2020/11/JaZBMzV14fzRI4vBWG8jymplSUGSGgimkqtJakOV.jpeg";

  _getAvatarPath() async {
    final pref = await getSharedPref();
    setState(() {
      userAvatarPath = pref.getString(USER_AVATAR_PATH_KEY);
    });
  }

  @override
  void initState() {
    super.initState();
    _getAvatarPath();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).appBarTheme.iconTheme,
      backgroundColor: Theme.of(context).accentColor,
      centerTitle: true,
      title: Text(widget.title,
          style: Theme.of(context).appBarTheme.titleTextStyle),
      elevation: 0,
      leading: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundImage: NetworkImage(userAvatarPath),
          ),
        ),
      ),
      actions: [
        IconButton(
            icon: FaIcon(
              FontAwesomeIcons.cog,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            })
      ],
    );
  }
}
