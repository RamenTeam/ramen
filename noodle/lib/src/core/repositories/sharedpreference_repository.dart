import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/core/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPref() async {
  return await SharedPreferences.getInstance();
}

class PersistentStorage {
  static setUser(User user) async {
    SharedPreferences pref = await getSharedPref();

    pref.setString(USER_ID_KEY, user.id);
    pref.setString(USER_AVATAR_PATH_KEY, user.avatarPath);
    pref.setString(USER_NAME_KEY, user.firstName + " " + user.lastName);
    pref.setString(USER_USERNAME_KEY, user.username);
    pref.setString(USER_EMAIL_KEY, user.email);
    pref.setString(USER_PHONE_NUMBER_KEY, user.phoneNumber);
    pref.setString(USER_BIO_KEY, user.bio);
  }

  static setRTCClient(String clientId) async {
    SharedPreferences pref = await getSharedPref();

    pref.setString(RTC_CLIENT_ID, clientId);
  }

  static setRTCRoom(String hostId, String peerId) async {
    SharedPreferences pref = await getSharedPref();

    pref.setString(RTC_HOST_ID, hostId);
    pref.setString(RTC_PEER_ID, hostId);
  }
}
