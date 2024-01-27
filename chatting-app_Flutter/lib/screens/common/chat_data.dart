import 'package:firebase_database/firebase_database.dart';
import 'package:flash_chat_flutter_app_challenge/components/dialog_widgets.dart';
import 'package:flash_chat_flutter_app_challenge/components/message_bubble.dart';
import 'package:flash_chat_flutter_app_challenge/global_variable.dart';
import 'package:flash_chat_flutter_app_challenge/services/firebase_service/database_service.dart';
import 'package:flutter/material.dart';

import '../../models/chat_model.dart';

class ChatData extends StatefulWidget {
  String _dbUrl;

  ChatData(this._dbUrl, {super.key});

  @override
  State<ChatData> createState() => _ChatDataState();
}

class _ChatDataState extends State<ChatData> {
  late final DatabaseReference _chatMsgStream;

  @override
  void initState() {
    super.initState();
    _chatMsgStream = FirebaseDatabaseService.getChatMsg(widget._dbUrl);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _chatMsgStream.orderByChild(dbMsgTimestampKey).onValue,
        builder: (streamContext, snapshot) {
          if (!snapshot.hasData) {
            return DialogWidgets.showProgressIndicator();
          } else {
            List<ChatModel> listOfChatModel = [];
            final children = snapshot.data!.snapshot.children;

            for (var child in children) {
              print('Chat Data : ${child.key}');
              if (child.value is! int) {
                final data = child.value as Map<dynamic, dynamic>;
                listOfChatModel.add(ChatModel.fromSnapshot(data));
              }
            }
            listOfChatModel = listOfChatModel.reversed.toList();
            return Expanded(
              child: ListView.builder(
                  reverse: true,
                  itemCount: listOfChatModel.length,
                  itemBuilder: (listViewContext, index) {
                    return MsgBubble(
                        timestamp: listOfChatModel[index].timestamp,
                        msg: listOfChatModel[index].content,
                        sender: listOfChatModel[index].sender,
                        isSenderMe: listOfChatModel[index].sender.trim() ==
                            getLoggedUserEmail().trim());
                  }),
            );
          }
        });
  }
}
