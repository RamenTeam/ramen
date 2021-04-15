import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_bloc.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_event.dart';
import 'package:provider/provider.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  HomeBottomNavigationBar({required this.tabIndex});

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    void onTabSelected(index) {
      Provider.of<TabNavigationBloc>(context, listen: false)
          .add(TabSwitchEvent(index));
    }

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
      onTap: onTabSelected,
    );
  }
}
