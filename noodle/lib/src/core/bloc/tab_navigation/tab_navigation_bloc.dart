import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/tab_navigation/tab_navigation_event.dart';

class TabNavigationBloc extends Bloc<TabNavigationEvent, int> {
  TabNavigationBloc({required int initialTabIndex}) : super(initialTabIndex);

  @override
  Stream<int> mapEventToState(TabNavigationEvent event) async* {
    if (event is TabSwitchEvent) {
      yield event.tabIndex;
    }
  }
}
