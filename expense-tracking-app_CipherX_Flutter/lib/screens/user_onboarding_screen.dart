import 'package:expense_tracking_app/constants.dart';
import 'package:expense_tracking_app/screens/color_constants.dart';
import 'package:flutter/material.dart';

class UserOnboardingScreen extends StatefulWidget {
  @override
  _UserOnboardingScreenState createState() => _UserOnboardingScreenState();
}

class _UserOnboardingScreenState extends State<UserOnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppThemeColor,
      body: Center(
        child: Text('Getting Started Screen'),
      ),
    );
  }
}
