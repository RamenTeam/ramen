import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/bloc/profile/profile_bloc.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_event.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:noodle/src/resources/pages/navigation/local_widget/home_bottom_nav_bar.dart';
import 'package:noodle/src/resources/pages/profile/profile.dart';
import 'package:noodle/src/resources/pages/interaction/meeting.dart';
import 'package:noodle/src/resources/theme/theme.dart';
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
          BlocProvider<TabNavigationBloc>(
            create: (_) => TabNavigationBloc(initialTabIndex: 0),
          ),
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(
              userRepository:
                  Provider.of<UserRepository>(context, listen: false),
            ),
          ),
        ],
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
        ));
  }
}
