import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_bloc.dart';

class TabNavigationProvider extends StatelessWidget {
  TabNavigationProvider({
    required this.navigator,
    this.initialTabIndex = 0,
  });

  final int initialTabIndex;
  final Widget navigator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabNavigationBloc>(
      create: (_) => TabNavigationBloc(initialTabIndex: initialTabIndex),
      child: navigator,
    );
  }
}
