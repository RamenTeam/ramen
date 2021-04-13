import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/bloc/profile/profile_bloc.dart';
import 'package:noodle/src/core/bloc/profile/profile_state.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/pages/profile/local_build/build_bio.dart';
import 'package:noodle/src/resources/pages/profile/local_build/build_hobbies.dart';
import 'package:noodle/src/resources/pages/profile/local_widget/info_header.dart';
import 'package:noodle/src/resources/pages/setting/setting.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    Widget buildInfoSection(User user) {
      return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
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
                  height: 20,
                ),
                ProfileInfoHeader(
                  firstName: user.firstName,
                  lastName: user.lastName,
                  username: user.username,
                ),
                buildBio(context: context, bio: user.bio),
                /* As we don't have this feature yet so I will comment it out @chungquantin
                  buildHobbies()
                  */
              ],
            ),
          ),
        );
      });
    }

    return Scaffold(
        body: Stack(
      children: [
        Container(
            // does the container below needed? it may have create the empty space next to the img
            child: Container(
          child: Image.network(
              "https://pbs.twimg.com/profile_images/1349755150316040194/VpUCtbH8_400x400.jpg"),
        )),
        buildInfoSection(),
        Container(
          height: 60,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.cog,
                    color: Colors.white,

//     return BlocProvider<ProfileBloc>(
//       create: (_) => ProfileBloc(user: User.mock()),
//       child: BlocBuilder<ProfileBloc, ProfileState>(
//         builder: (context, state) {
//           final User user = state.user;
//           return Container(
//             child: Stack(
//               children: [
//                 Container(
//                     child: Container(
//                   child: Image.network(
//                     user.avatarPath,
                  ),
                )),
                buildInfoSection(user),
                Container(
                  height: 60,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.cog,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingScreen()));
                          })
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
