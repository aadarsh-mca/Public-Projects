import 'package:flash_chat_flutter_app_challenge/screens/common/welcome_screen.dart';
import 'package:flutter/material.dart';

class TabWelcomeScreen extends StatefulWidget {
  @override
  _TabWelcomeScreenState createState() => _TabWelcomeScreenState();
}

class _TabWelcomeScreenState extends State<TabWelcomeScreen>
    with WelcomeScreenMixin {
  List<Color> colorList = [Colors.red, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: getAppBar(),
      body: getBody(),
    );
  }
}
