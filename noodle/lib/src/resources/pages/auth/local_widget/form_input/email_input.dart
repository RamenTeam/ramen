import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/login/login_cubit.dart';
import 'package:noodle/src/core/bloc/login/login_state.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (value) => Provider.of<LoginCubit>(
              context,
              listen: false,
            ).emailChanged(value),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              helperText: '',
              errorText: state.email.invalid ? 'Invalid email' : null,
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
