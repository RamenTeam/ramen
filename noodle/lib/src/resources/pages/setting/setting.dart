import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/resources/pages/setting/local_build/build_app_bar.dart';
import 'package:noodle/src/resources/pages/setting/local_build/build_setting_item.dart';
import 'package:noodle/src/resources/theme/theme.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'local_build/build_setting_separator.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = AppTheme.of(context).currentThemeKey == AppThemeKeys.dark;

    Widget buildAdaptiveSwitch() {
      return PlatformSwitch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
            AppTheme.of(context).switchTheme();
            print(AppTheme.of(context).currentThemeKey);
          });
        },
        material: (_, __) => MaterialSwitchData(
          activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.5),
          activeColor: Theme.of(context).primaryColor,
          inactiveTrackColor: Colors.grey,
        ),
        cupertino: (_, __) => CupertinoSwitchData(
          activeColor: Theme.of(context).primaryColor,
        ),
      );
    }

    Widget buildSettingArea(List<Widget> children) {
      return Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(15)),
          child: Column(children: children));
    }

    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Theme.of(context).accentColor,
      body: ListView(
        children: [
          buildSettingArea([
            buildSettingItem(
                context: context,
                onTapEvent: () {},
                leftChildren: [
                  Text(
                    "Dark mode",
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
                rightChildren: [
                  buildAdaptiveSwitch()
                ]),
            buildSettingSeparator(context: context),
            buildSettingItem(
                context: context,
                onTapEvent: () {},
                leftChildren: [
                  Text(
                    "App Language",
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
                rightChildren: [
                  Text(
                    "English",
                    style: TextStyle(
                        color: Theme.of(context).primaryIconTheme.color),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 15,
                    color: Theme.of(context).primaryIconTheme.color,
                  )
                ]),
            buildSettingSeparator(context: context),
            buildSettingItem(
                context: context,
                onTapEvent: () {},
                leftChildren: [
                  Text(
                    "Notifications",
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
                rightChildren: [
                  Text(
                    "Off until 7:00PM",
                    style: TextStyle(
                        color: Theme.of(context).primaryIconTheme.color),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 15,
                    color: Theme.of(context).primaryIconTheme.color,
                  )
                ]),
          ]),
          buildSettingArea([
            buildSettingItem(
                context: context,
                onTapEvent: () {},
                leftChildren: [
                  Text(
                    "Contributors",
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
                rightChildren: [
                  Text(
                    "4 contributors",
                    style: TextStyle(
                        color: Theme.of(context).primaryIconTheme.color),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 15,
                    color: Theme.of(context).primaryIconTheme.color,
                  )
                ]),
          ]),
          buildSettingArea([
            buildSettingItem(
                context: context,
                onTapEvent: () {},
                leftChildren: [
                  Text(
                    "Current version",
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
                rightChildren: [
                  Text(
                    "v1.0.0",
                    style: TextStyle(
                        color: Theme.of(context).primaryIconTheme.color),
                  ),
                ]),
          ])
        ],
      ),
    );
  }
}