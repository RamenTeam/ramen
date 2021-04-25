import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/resources/pages/register/bloc/register_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/bloc/update_profile_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/bloc/update_profile_state.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/shared/form_input.dart';
import 'package:noodle/src/resources/shared/submit_button.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class UpdateProfileForm extends StatelessWidget {
  UpdateProfileForm({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    UpdateProfileCubit updateProfileCubit = Provider.of<UpdateProfileCubit>(
        context, listen: false);
    updateProfileCubit.firstNameChanged(user.firstName);
    updateProfileCubit.lastNameChanged(user.lastName);
    updateProfileCubit.bioChanged(user.bio);
    return Scaffold(
        appBar: _AppBar(context),
        backgroundColor: Theme
            .of(context)
            .accentColor,
        body: Center(
          child: Padding(
            child: ListView(
              children: [
                SizedBox(height: 25),
                Text(
                  'Update your profile',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .textTheme
                          .headline1
                          ?.color),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: _FirstNameInput(initialValue: user.firstName)),
                    SizedBox(width: 10),
                    Flexible(
                        child: _LastNameInput(initialValue: user.lastName)),
                  ],
                ),
                SizedBox(height: 15),
                _BioInput(initialValue: user.bio),
                SizedBox(height: 15),
                SubmitButton(
                  content: Text("Save changes"),
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressCallback: () {
                    print("Update profile");
                    updateProfileCubit.updateProfile();
                  },
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 40),
          ),
        ));
  }
}

AppBar _AppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Icon(
              Icons.arrow_back_ios_outlined,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
            GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Text(
                "Back",
                style: TextStyle(
                  fontSize: 13,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
              ),
            )
          ],
        ),
        Spacer(),
        Container(
            child: Text(
              "Update profile",
              style: Theme
                  .of(context)
                  .appBarTheme
                  .titleTextStyle,
            ),
            margin: EdgeInsets.only(right: 50)),
        Spacer(),
        Container()
      ],
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}

class _FirstNameInput extends StatelessWidget {
  _FirstNameInput({initialValue = ''}) {
    controller.text = initialValue;
  }

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return Container(
            child: FormInput(
                controller: controller,
                onChangedCallback: (value) =>
                    Provider.of<UpdateProfileCubit>(context, listen: false)
                        .firstNameChanged(value),
                labelText: 'First name',
                errorText: state.firstName.invalid ? 'Invalid name' : null,
                inputKey: 'registerForm_firstNameInput_textField'));
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  _LastNameInput({initialValue = ''}) {
    controller.text = initialValue;
  }

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return Container(
            child: FormInput(
                controller: controller,
                onChangedCallback: (value) =>
                    Provider.of<UpdateProfileCubit>(context, listen: false)
                        .lastNameChanged(value),
                labelText: 'Last name',
                errorText: state.lastName.invalid ? 'Invalid name' : null,
                inputKey: 'registerForm_lastNameInput_textField'));
      },
    );
  }
}

class _BioInput extends StatelessWidget {
  _BioInput({initialValue = ''}) {
    controller.text = initialValue;
  }

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) => previous.bio != current.bio,
      builder: (context, state) {
        return Container(
          child: FormInput(
            controller: controller,
            onChangedCallback: (value) =>
                Provider.of<UpdateProfileCubit>(context, listen: false)
                    .bioChanged(value),
            labelText: 'Bio',
            errorText: state.bio.invalid ? 'Maximum 500 characters' : null,
            textInputType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            inputKey: 'registerForm_lastNameInput_textField',
            lines: 3,
          ),
        );
      },
    );
  }
}
