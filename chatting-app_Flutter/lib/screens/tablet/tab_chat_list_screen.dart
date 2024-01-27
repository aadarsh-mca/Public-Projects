import 'package:flash_chat_flutter_app_challenge/screens/common/chat_list_data.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/chat_list_screen.dart';
import 'package:flutter/material.dart';

class TabChatListScreen extends StatefulWidget {
  const TabChatListScreen({super.key});

  @override
  State<TabChatListScreen> createState() => _TabChatListScreenState();
}

class _TabChatListScreenState extends State<TabChatListScreen>
    with ChatListScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: ChatListData(),
    );
  }
}
