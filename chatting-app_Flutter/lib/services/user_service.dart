import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter_app_challenge/components/dialog_widgets.dart';
import 'package:flash_chat_flutter_app_challenge/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_service/firebase_auth_service.dart';

class UserService {
  static Future<Map<String, dynamic>> getLoggedInUser() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    bool? userStatus = sharedPref.getBool(kLoggedUserStatusKey);
    String? userEmail = sharedPref.getString(kLoggedUserEmailKey);

    Map<String, dynamic> userData = {
      kLoggedUserStatusKey: userStatus,
      kLoggedUserEmailKey: userEmail,
    };
    return userData;
  }

  static User? getCurrentAuthUser(BuildContext context) {
    return FirebaseAuthService(context: context).getCurrentAuthUser();
  }

  static Future<void> loginService(
      {required BuildContext context,
      required String userEmail,
      required String userPassword,
      required String nextScreenName}) async {
    DialogWidgets.showCircularProgressIndicator();
    FirebaseAuthService auth = FirebaseAuthService(context: context);

    User? user = await auth.loginUserWithPassword(
        userEmail: userEmail, userPassword: userPassword);
    DialogWidgets.hideCircularProgressIndicator();
    if (user != null) {
      // Navigator.pushReplacementNamed(context, screenRouteAsNamed);
      Navigator.pushNamedAndRemoveUntil(
          context, nextScreenName, (route) => false);
    }
  }

  static Future<void> registerService(
      {required BuildContext context,
      required String userEmail,
      required String userPassword,
      required String nextScreenName}) async {
    DialogWidgets.showCircularProgressIndicator();
    FirebaseAuthService auth = FirebaseAuthService(context: context);

    User? user = await auth.createUserWithPassword(
        userEmail: userEmail, userPassword: userPassword);
    DialogWidgets.hideCircularProgressIndicator();
    if (user != null) {
      // Navigator.pushReplacementNamed(context, screenRouteAsNamed);
      Navigator.pushNamedAndRemoveUntil(
          context, nextScreenName, (route) => false);
    }
  }
}
