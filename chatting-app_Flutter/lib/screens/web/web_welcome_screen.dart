import 'package:flash_chat_flutter_app_challenge/screens/common/welcome_screen.dart';
import 'package:flutter/material.dart';

class WebWelcomeScreen extends StatefulWidget {
  const WebWelcomeScreen({super.key});

  @override
  State<WebWelcomeScreen> createState() => _WebWelcomeScreenState();
}

class _WebWelcomeScreenState extends State<WebWelcomeScreen>
    with WelcomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: getAppBar(),
      body: getBody(),
    );
  }
}
