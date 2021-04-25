import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/resources/pages/profile/bloc/profile_cubit.dart';
import 'package:noodle/src/resources/pages/register/bloc/register_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/bloc/update_profile_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/bloc/update_profile_state.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/shared/form_input.dart';
import 'package:noodle/src/resources/shared/submit_button.dart';

class UpdateProfileScreen extends StatelessWidget {
  final ProfileCubit profileCubit;
  final UpdateProfileCubit updateProfileCubit;

  const UpdateProfileScreen(
      {required this.profileCubit, required this.updateProfileCubit});

  @override
  Widget build(BuildContext context) {
    void updateProfile() async {
      await updateProfileCubit.updateProfile();
      print("Profile updated on server");
      await profileCubit.fetchUser();
      print("Profile fetched to client");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Update profile succesfully!")));
    }

    User? user = profileCubit.getUser();
    if (user == null) {
      Navigator.pop(context);
      return Container();
    }
    updateProfileCubit.firstNameChanged(user.firstName);
    updateProfileCubit.lastNameChanged(user.lastName);
    updateProfileCubit.bioChanged(user.bio);
    return Scaffold(
        appBar: _AppBar(context),
        backgroundColor: Theme.of(context).accentColor,
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
                      color: Theme.of(context).textTheme.headline1?.color),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: _FirstNameInput(
                      initialValue: user.firstName,
                      updateProfileCubit: updateProfileCubit,
                    )),
                    SizedBox(width: 10),
                    Flexible(
                        child: _LastNameInput(
                      initialValue: user.lastName,
                      updateProfileCubit: updateProfileCubit,
                    )),
                  ],
                ),
                SizedBox(height: 15),
                _BioInput(
                  initialValue: user.bio,
                  updateProfileCubit: updateProfileCubit,
                ),
                SizedBox(height: 15),
                SubmitButton(
                  content: Text("Save changes"),
                  color: Theme.of(context).primaryColor,
                  onPressCallback: updateProfile,
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
              color: Theme.of(context).primaryColor,
            ),
            GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Text(
                "Back",
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
        Spacer(),
        Container(
            child: Text(
              "Update profile",
              style: Theme.of(context).appBarTheme.titleTextStyle,
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
  _FirstNameInput({initialValue = '', required this.updateProfileCubit}) {
    controller.text = initialValue;
  }

  final UpdateProfileCubit updateProfileCubit;

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      cubit: updateProfileCubit,
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return Container(
            child: FormInput(
                controller: controller,
                onChangedCallback: (value) =>
                    updateProfileCubit.firstNameChanged(value),
                labelText: 'First name',
                errorText: state.firstName.invalid ? 'Invalid name' : null,
                inputKey: 'registerForm_firstNameInput_textField'));
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  _LastNameInput({initialValue = '', required this.updateProfileCubit}) {
    controller.text = initialValue;
  }

  TextEditingController controller = new TextEditingController();
  final UpdateProfileCubit updateProfileCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      cubit: updateProfileCubit,
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return Container(
            child: FormInput(
                controller: controller,
                onChangedCallback: (value) =>
                    updateProfileCubit.lastNameChanged(value),
                labelText: 'Last name',
                errorText: state.lastName.invalid ? 'Invalid name' : null,
                inputKey: 'registerForm_lastNameInput_textField'));
      },
    );
  }
}

class _BioInput extends StatelessWidget {
  _BioInput({initialValue = '', required this.updateProfileCubit}) {
    controller.text = initialValue;
  }

  TextEditingController controller = new TextEditingController();
  final UpdateProfileCubit updateProfileCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      cubit: updateProfileCubit,
      buildWhen: (previous, current) => previous.bio != current.bio,
      builder: (context, state) {
        return Container(
          child: FormInput(
            controller: controller,
            onChangedCallback: (value) => updateProfileCubit.bioChanged(value),
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
