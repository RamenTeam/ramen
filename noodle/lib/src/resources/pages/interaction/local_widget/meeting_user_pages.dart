import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:noodle/src/resources/pages/interaction/local_widget/video_player.dart';
import 'package:noodle/src/resources/pages/interaction/local_widget/interaction_options.dart';
import 'package:noodle/src/resources/pages/interaction/local_widget/meeting_user_info.dart';

Widget buildPages(BuildContext context, Size screenSize) {
  return Stack(
    children: [
      VideoApp(),
      buildMeetingUserInfo(context, screenSize),
      buildInteractionOptions(context),
    ],
  );
}
