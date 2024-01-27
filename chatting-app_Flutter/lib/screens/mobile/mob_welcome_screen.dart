import 'package:flash_chat_flutter_app_challenge/screens/common/welcome_screen.dart';
import 'package:flutter/material.dart';

class MobWelcomeScreen extends StatefulWidget {
  @override
  _MobWelcomeScreenState createState() => _MobWelcomeScreenState();
}

class _MobWelcomeScreenState extends State<MobWelcomeScreen>
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
