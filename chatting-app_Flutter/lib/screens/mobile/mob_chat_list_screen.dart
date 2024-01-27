import 'package:flash_chat_flutter_app_challenge/screens/common/chat_list_data.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/chat_list_screen.dart';
import 'package:flutter/material.dart';

class MobChatListScreen extends StatefulWidget {
  MobChatListScreen({super.key});

  _MobChatListScreenState createState() => _MobChatListScreenState();
}

class _MobChatListScreenState extends State<MobChatListScreen>
    with ChatListScreenMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: ChatListData(),
    );
  }
}
