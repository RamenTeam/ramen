import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/bloc/home/home_cubit.dart';
import 'package:noodle/src/core/bloc/profile/profile_bloc.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_cubit.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:noodle/src/resources/pages/profile/profile.dart';
import 'package:provider/provider.dart';
import 'package:noodle/src/resources/pages/notifications/notifications.dart';

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
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(
              userRepository:
                  Provider.of<UserRepository>(context, listen: false),
            ),
          ),
          BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(),
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

// ignore: must_be_immutable
class _HomeBottomNavigationBar extends StatelessWidget {
  _HomeBottomNavigationBar({required this.tabIndex});
  int _numberOfNotification =
      99; //TODO: set a limit < 100 so when there is more than 100 notification, the number will be 99+
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
          icon: Badge(
            badgeContent: Text(
                '$_numberOfNotification'), //TODO: fetch the number of unread notifcation
            child: FaIcon(FontAwesomeIcons.bell),
          ),
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
