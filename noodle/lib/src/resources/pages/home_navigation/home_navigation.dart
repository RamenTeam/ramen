import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:noodle/src/resources/pages/home_navigation//bloc/tab_navigation_cubit.dart';
import 'package:noodle/src/resources/pages/notifications/notifications.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';
import 'package:noodle/src/resources/pages/profile/profile.dart';
import 'package:provider/provider.dart';

class HomeNavigation extends StatelessWidget {
  Widget currentTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return ViewNotifications();
      case 2:
        return ProfileScreen();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TabNavigationCubit>(
            create: (_) => TabNavigationCubit(initialTabIndex: 0),
          ),
          BlocProvider<UserCubit>(
            create: (_) => UserCubit(
              userRepository:
                  Provider.of<UserRepository>(context, listen: false),
            )..fetchUser(),
          ),
        ],
        child: BlocBuilder<TabNavigationCubit, int>(
          builder: (builder, tabIndex) {
            return SafeArea(
              child: Scaffold(
                body: currentTab(tabIndex),
                backgroundColor: Theme.of(context).accentColor,
                bottomNavigationBar: _HomeBottomNavigationBar(
                  tabIndex: tabIndex,
                ),
              ),
            );
          },
        ));
  }
}

class _HomeBottomNavigationBar extends StatelessWidget {
  _HomeBottomNavigationBar({required this.tabIndex});

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: tabIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.globeAsia),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.bell),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.userAstronaut),
          label: 'Profile',
        ),
      ],
      onTap: (tabIndex) {
        Provider.of<TabNavigationCubit>(context, listen: false)
            .switchTab(tabIndex);
      },
    );
  }
}
