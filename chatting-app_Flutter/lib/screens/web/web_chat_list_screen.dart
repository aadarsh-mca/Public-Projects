import 'package:flash_chat_flutter_app_challenge/screens/common/chat_list_data.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/chat_list_screen.dart';
import 'package:flutter/material.dart';

class WebChatListScreen extends StatefulWidget {
  const WebChatListScreen({super.key});

  @override
  State<WebChatListScreen> createState() => _WebChatListScreenState();
}

class _WebChatListScreenState extends State<WebChatListScreen>
    with ChatListScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: ChatListData(),
    );
  }
}
