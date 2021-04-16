import 'package:flutter_bloc/flutter_bloc.dart';

class TabNavigationCubit extends Cubit<int> {
  TabNavigationCubit({int initialTabIndex = 0}) : super(initialTabIndex);

  void switchTab(int tabIndex) {
    emit(tabIndex);
  }
}
