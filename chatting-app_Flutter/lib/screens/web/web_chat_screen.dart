import 'package:flash_chat_flutter_app_challenge/models/chat_list_model.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/chat_screen.dart';
import 'package:flutter/material.dart';

class WebChatScreen extends StatefulWidget {
  final ChatListModel? _chatListModel;

  const WebChatScreen(this._chatListModel, {super.key});

  @override
  State<WebChatScreen> createState() => _WebChatScreenState();
}

class _WebChatScreenState extends State<WebChatScreen> with ChatScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(widget._chatListModel),
      body: getBody(widget._chatListModel),
    );
  }
}
