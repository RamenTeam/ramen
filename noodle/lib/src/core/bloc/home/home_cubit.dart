import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void find() {
    emit(state.copyWith(
      status: HomeStatus.Finding,
    ));
  }

  void cancelFind() {
    emit(state.copyWith(
      status: HomeStatus.Idle,
    ));
  }
}
