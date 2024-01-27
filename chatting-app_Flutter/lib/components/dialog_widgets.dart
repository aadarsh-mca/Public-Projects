import 'package:flash_chat_flutter_app_challenge/components/custom_snack_bar.dart';
import 'package:flash_chat_flutter_app_challenge/global_variable.dart';
import 'package:flash_chat_flutter_app_challenge/main.dart';
import 'package:flash_chat_flutter_app_challenge/services/firebase_service/database_service.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class DialogWidgets {
  static Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.lightBlueAccent[700],
        color: Colors.red,
      ),
    );
  }

  static Future<dynamic> showCircularProgressIndicator() {
    return showDialog(
        context: globalNavigatorKey.currentContext!,
        builder: (builderContext) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent[700],
                color: Colors.red,
              ),
            ),
          );
        });
  }

  static void hideCircularProgressIndicator() {
    Navigator.of(globalNavigatorKey.currentContext!).pop();
  }
}
