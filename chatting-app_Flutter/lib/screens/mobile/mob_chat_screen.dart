import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flash_chat_flutter_app_challenge/components/custom_snack_bar.dart';
import 'package:flash_chat_flutter_app_challenge/components/message_bubble.dart';
import 'package:flash_chat_flutter_app_challenge/constants.dart';
import 'package:flash_chat_flutter_app_challenge/global_variable.dart';
import 'package:flash_chat_flutter_app_challenge/models/chat_list_model.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/chat_data.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/chat_screen.dart';
import 'package:flash_chat_flutter_app_challenge/services/firebase_service/database_service.dart';
import 'package:flash_chat_flutter_app_challenge/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter_app_challenge/constants.dart';
import 'package:flash_chat_flutter_app_challenge/services/firebase_service/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MobChatScreen extends StatefulWidget {
  final ChatListModel? _chatListModel;

  const MobChatScreen(this._chatListModel, {super.key});

  @override
  _MobChatScreenState createState() => _MobChatScreenState();
}

class _MobChatScreenState extends State<MobChatScreen> with ChatScreenMixin {
  @override
  Widget build(BuildContext context) {
    // print(
    //     'data from pref map : ${widget._chatListModel?.email}--${widget._chatListModel?.dbUrl}');
    // // ChatData(widget._chatListModel!.dbUrl);
    return Scaffold(
      appBar: getAppBar(widget._chatListModel),
      body: getBody(widget._chatListModel),
    );
  }
}
