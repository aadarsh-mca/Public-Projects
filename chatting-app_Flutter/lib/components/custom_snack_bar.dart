import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  String msg;
  CustomSnackBar({required this.msg});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SnackBar(
      content: Text(msg),
      width: (MediaQuery.of(context).size.width * 0.9),
      duration: Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ));
  }

}
