import 'package:flutter/material.dart';
import 'package:ram_mandir_history_project/constants.dart';

class DisplaySnackBar {
  static void showSnackMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: kSaffronColor,
      width: 320.0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1000),
      dismissDirection: DismissDirection.startToEnd,
      padding: const EdgeInsets.all(8.0),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ));
  }
}
