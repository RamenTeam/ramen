import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_event.dart';
import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:noodle/src/resources/pages/navigation/local_widget/home_bottom_nav_bar.dart';
import 'package:noodle/src/resources/pages/profile/profile.dart';
import 'package:noodle/src/resources/pages/interaction/meeting.dart';
import 'package:noodle/src/resources/theme/theme.dart';

class HomeNavigation extends StatelessWidget {
  Widget currentTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return MeetingScreen();
      case 2:
        return ProfileScreen();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabNavigationBloc>(
      create: (_) => TabNavigationBloc(initialTabIndex: 0),
      child: BlocBuilder<TabNavigationBloc, int>(
        builder: (builder, tabIndex) {
          return SafeArea(
            child: Scaffold(
              body: currentTab(tabIndex),
              backgroundColor: Theme.of(context).accentColor,
              bottomNavigationBar: HomeBottomNavigationBar(
                tabIndex: tabIndex,
              ),
            ),
          );
        },
      ),
    );
  }
}
