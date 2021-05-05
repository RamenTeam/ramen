import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';
import 'package:noodle/src/resources/pages/setting/setting.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar(
      {required this.userRepository,
      required this.userCubit,
      required this.title});

  final UserRepository userRepository;
  final UserCubit userCubit;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String title;

  @override
  Widget build(BuildContext context) {
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
            child: BlocBuilder<UserCubit, User?>(
              cubit: userCubit,
              builder: (context, state) {
                return CircleAvatar(
                  backgroundImage: NetworkImage(state == null
                      ? User.defaultAvatarPath
                      : state.avatarPath),
                );
              },
            )),
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
                  userCubit: userCubit,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
