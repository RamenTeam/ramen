import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_event.dart';
import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:noodle/src/resources/pages/profile/profile.dart';
import 'package:noodle/src/resources/theme/theme.dart';
import 'package:provider/provider.dart';

class HomeNavigation extends StatefulWidget {
  HomeNavigation({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeNavigation());
  }

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  AppTheme? _theme;

  @override
  void didChangeDependencies() {
    if (_theme == null) {
      _theme = AppTheme.of(context);
    }

    super.didChangeDependencies();
  }

  void onTabSelected(index) {
    Provider.of<TabNavigationBloc>(context, listen: false)
        .add(TabSwitchEvent(index));
  }

  Widget currentTab() {
    return BlocBuilder<TabNavigationBloc, int>(builder: (context, tabIndex) {
      switch (tabIndex) {
        case 0:
          return HomeScreen();
        case 1:
          return ProfileScreen();
        default:
          return Container();
      }
    });
  }

  Widget bottomNavBar() {
    return BlocBuilder<TabNavigationBloc, int>(builder: (context, tabIndex) {
      return BottomNavigationBar(
        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.globeAsia),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userAstronaut),
            label: 'Profile',
          ),
        ],
        onTap: onTabSelected,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: currentTab(),
        backgroundColor: Theme.of(context).accentColor,
        bottomNavigationBar: bottomNavBar(),
      ),
    );
  }
}
