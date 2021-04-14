import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/login/login_cubit.dart';
import 'package:noodle/src/core/bloc/login/login_state.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (value) => Provider.of<LoginCubit>(
              context,
              listen: false,
            ).passwordChanged(value),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              helperText: '',
              errorText: state.password.invalid ? 'Invalid password' : null,
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Colors.grey, width: 0.3),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        );
      },
    );
  }
}
