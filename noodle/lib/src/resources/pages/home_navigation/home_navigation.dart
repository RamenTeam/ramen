import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noodle/src/core/repositories/notification_repository.dart';
import 'package:noodle/src/resources/pages/chat/chat_screen.dart';
import 'package:noodle/src/resources/pages/home/home.dart';
import 'package:noodle/src/resources/pages/home_navigation//bloc/tab_navigation_cubit.dart';
import 'package:noodle/src/resources/pages/notifications/bloc/notification_cubit.dart';
import 'package:noodle/src/resources/pages/notifications/bloc/notification_state.dart';
import 'package:noodle/src/resources/pages/notifications/notification_screen.dart';
import 'package:noodle/src/resources/pages/profile/profile.dart';
import 'package:provider/provider.dart';

class HomeNavigation extends StatefulWidget {
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  @override
  void initState() {
    super.initState();
    // Fetch notifications first
    Provider.of<NotificationCubit>(context, listen: false).fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TabNavigationCubit>(
            create: (_) => TabNavigationCubit(initialTabIndex: 0),
          ),
        ],
        child: BlocBuilder<TabNavigationCubit, int>(
          builder: (builder, tabIndex) {
            return SafeArea(
              child: Scaffold(
                body: Stack(children: [
                  StreamListener<QueryResult>(
                    stream: Provider.of<NotificationRepository>(context,
                            listen: false)
                        .getNewNotificationStream(),
                    onData: (data) {
                      print("Hello");
                      Provider.of<NotificationCubit>(context, listen: false)
                          .fetchNotifications();
                    },
                    child: Container(),
                  ),
                  _CurrentTab(tabIndex: tabIndex),
                ]),
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

class _CurrentTab extends StatelessWidget {
  _CurrentTab({required this.tabIndex});

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    switch (tabIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return NotificationScreen();
      case 2:
        return ChatScreen();
      case 3:
        return ProfileScreen();
      default:
        return Container();
    }
  }
}

// ignore: must_be_immutable
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
          icon: Badge(
            badgeContent: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                return Text(state.notifications.length.toString());
              },
            ),
            //TODO: fetch the number of unread notifcation
            child: FaIcon(FontAwesomeIcons.bell),
          ),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.facebookMessenger),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.userAstronaut),
          label: 'Profile',
        ),
      ],
      onTap: (tabIndex) {
        Provider.of<TabNavigationCubit>(context, listen: false)
            .switchTab(tabIndex);
        if (tabIndex == 1)
          Provider.of<NotificationCubit>(context, listen: false)
              .fetchNotifications();
      },
    );
  }
}
