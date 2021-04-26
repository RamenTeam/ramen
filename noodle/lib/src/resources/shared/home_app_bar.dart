import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/pages/auth/bloc/auth_bloc.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';
import 'package:noodle/src/resources/pages/setting/setting.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar(
      {required this.authBloc, required this.userCubit, required this.title});

  final AuthenticationBloc authBloc;
  final UserCubit userCubit;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String title;

  @override
  Widget build(BuildContext context) {
    final User? user = userCubit.getUser();
    return AppBar(
      iconTheme: Theme.of(context).appBarTheme.iconTheme,
      backgroundColor: Theme.of(context).accentColor,
      centerTitle: true,
      title: Text(title, style: Theme.of(context).appBarTheme.titleTextStyle),
      elevation: 0,
      leading: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                user == null ? User.defaultAvatarPath : user.avatarPath),
          ),
        ),
      ),
      actions: [
        IconButton(
            icon: FaIcon(
              FontAwesomeIcons.cog,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingScreen(
                            authBloc: authBloc,
                          )));
            })
      ],
    );
  }
}
