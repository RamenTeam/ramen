import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:noodle/src/resources/pages/profile/profile.dart';
import 'package:noodle/src/resources/theme/theme.dart';

class HomeNavigation extends StatefulWidget {
  HomeNavigation({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeNavigation());
  }

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int tabIndex = 0;
  final List<Widget> tabs = [
    HomeScreen(),
    ProfileScreen(),
  ];

  AppTheme? _theme;

  @override
  void didChangeDependencies() {
    if (_theme == null) {
      _theme = AppTheme.of(context);
    }

    super.didChangeDependencies();
  }

  void onTabSelected(index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: tabs[tabIndex],
        backgroundColor: Theme.of(context).accentColor,
        bottomNavigationBar: BottomNavigationBar(
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
        ),
      ),
    );
  }
}
