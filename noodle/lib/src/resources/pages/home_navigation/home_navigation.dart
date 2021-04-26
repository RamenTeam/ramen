import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:noodle/src/resources/pages/home_navigation//bloc/tab_navigation_cubit.dart';
import 'package:noodle/src/resources/pages/profile/bloc/profile_cubit.dart';
import 'package:noodle/src/resources/pages/profile/profile.dart';
import 'package:provider/provider.dart';

class HomeNavigation extends StatelessWidget {
  Widget currentTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return HomeScreen();
/*      case 1:
        return MeetingScreen();*/
      case 1:
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
          BlocProvider<ProfileCubit>(
            create: (_) => ProfileCubit(
              userRepository:
                  Provider.of<UserRepository>(context, listen: false),
            ),
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
        /*       BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.userAstronaut),
          label: 'Meeting',
        ),*/
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
