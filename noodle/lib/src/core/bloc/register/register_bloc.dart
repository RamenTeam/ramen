import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/register/register_event.dart';
import 'package:noodle/src/core/bloc/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterError) {
      yield RegisterState(errorMessage: event.errorMessage);
    } else if (event is RegisterSuccess) {
      yield RegisterState(success: true);
    }
  }
}
