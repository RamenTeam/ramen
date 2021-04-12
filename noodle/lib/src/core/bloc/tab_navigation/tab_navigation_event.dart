// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

abstract class TabNavigationEvent extends Equatable {
  TabNavigationEvent(this.tabIndex);

  final int tabIndex;

  @override
  List<Object> get props => [];
}

class TabSwitchEvent extends TabNavigationEvent {
  TabSwitchEvent(tabIndex) : super(tabIndex);
}
