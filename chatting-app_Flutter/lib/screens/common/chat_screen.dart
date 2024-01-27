import 'package:flash_chat_flutter_app_challenge/constants.dart';
import 'package:flash_chat_flutter_app_challenge/global_variable.dart';
import 'package:flash_chat_flutter_app_challenge/models/chat_list_model.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/chat_data.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/screen_size.dart';
import 'package:flash_chat_flutter_app_challenge/screens/mobile/mob_chat_screen.dart';
import 'package:flash_chat_flutter_app_challenge/screens/tablet/tab_chat_screen.dart';
import 'package:flash_chat_flutter_app_challenge/screens/web/web_chat_screen.dart';
import 'package:flash_chat_flutter_app_challenge/services/firebase_service/database_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    final args = ModalRoute.of(context)!.settings.arguments as ChatListModel;

    if (_width < kTabletMinWidth) {
      return MobChatScreen(args);
    } else if (_width >= kTabletMinWidth && _width < kWebMinWidth) {
      return TabChatScreen(args);
    } else {
      return WebChatScreen(args);
    }
  }
}

mixin ChatScreenMixin<T extends StatefulWidget> on State<T> {
  final String _userEmail = getLoggedUserEmail();
  final TextEditingController _sendMsgController = TextEditingController();
  String _msg = '';

  @override
  void dispose() {
    _sendMsgController.dispose();
    super.dispose();
  }

  AppBar getAppBar(ChatListModel? chatListModel) {
    return AppBar(
      leading: Container(),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () async {
              // CustomSnackBar();
            }),
      ],
      title: Text(chatListModel!.email),
      backgroundColor: Colors.lightBlueAccent,
    );
  }

  Widget getBody(ChatListModel? chatListModel) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ChatData(chatListModel!.dbUrl),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _sendMsgController,
                    onChanged: (value) {
                      //Do something with the user input.
                      _msg = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    //Implement send functionality.
                    if (_msg.isNotEmpty) {
                      _sendMsgController.clear();
                      await FirebaseDatabaseService.sendMsgPvtChat(
                          chatListModel.email, _msg);
                    } else {
                      /// show Snack Bar
                    }
                  },
                  child: Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
