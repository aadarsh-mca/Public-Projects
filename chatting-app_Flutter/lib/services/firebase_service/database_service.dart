import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flash_chat_flutter_app_challenge/components/custom_snack_bar.dart';
import 'package:flash_chat_flutter_app_challenge/components/dialog_widgets.dart';
import 'package:flash_chat_flutter_app_challenge/constants.dart';
import 'package:flash_chat_flutter_app_challenge/global_variable.dart';
import 'package:flash_chat_flutter_app_challenge/main.dart';
import 'package:flash_chat_flutter_app_challenge/models/chat_model.dart';
import 'package:flutter/material.dart';

/// messages ->
/// loggedUser ->
/// allChatList -> chattingUserId
///

const String _dbMsgRoot = 'messages';
const String dbMsgTimestampKey = 'timestamp';
const String dbMsgContentKey = 'content';
const String dbMsgSenderKey = 'sender';
// String _loggedUserEmail = loggedUserData[kLoggedUserEmailKey];
// String getMsgDbPath = '$_dbMsgRoot/$_loggedUserEmail';
// String getMsgDbPath = '$_dbMsgRoot/${getLoggedUserEmail()}';

String getMsgDbPath() {
  return '$_dbMsgRoot/${getLoggedUserEmail()}';
}

class FirebaseDatabaseService {
  static final DatabaseReference _rtdbRef = FirebaseDatabase.instance.ref();

  static DatabaseReference getAllChatList() {
    return _rtdbRef.child(getMsgDbPath());
  }

  static DatabaseReference getChatMsg(String chatMsgDbUrl) {
    return _rtdbRef.child(chatMsgDbUrl);
  }

  static void getChatMsgFrom(String chatMsgDbUrl) async {
    DataSnapshot snapshot = await _rtdbRef
        .child(chatMsgDbUrl)
        // .orderByChild('$dbMsgTimestampKey')
        .get();
    for (var child in snapshot.children) {
      print('db service : ${child.key}');
    }
  }

  static Future<void> sendMsgPvtChat(String sendToEmail, String msgBody) async {
    sendToEmail = removeSpecialChar(sendToEmail!);

    String senderDbPath = '$_dbMsgRoot/${getLoggedUserEmail()}/$sendToEmail';
    String receiverDbPath = '$_dbMsgRoot/$sendToEmail/${getLoggedUserEmail()}';

    var msgData = {
      dbMsgTimestampKey: ServerValue.timestamp,
      dbMsgContentKey: msgBody,
      dbMsgSenderKey: getLoggedUserEmail(),
    };
    await _rtdbRef
        .child(senderDbPath)
        .update({dbMsgTimestampKey: ServerValue.timestamp});
    await _rtdbRef
        .child(receiverDbPath)
        .update({dbMsgTimestampKey: ServerValue.timestamp});

    await _rtdbRef.child(senderDbPath).push().set(msgData);
    await _rtdbRef.child(receiverDbPath).push().set(msgData);
  }

  static Future<void> sendMsgToEmail(
      ChatModel chatModel, String sendToEmail) async {
    DialogWidgets.showCircularProgressIndicator();

    chatModel.sender = removeSpecialChar(chatModel.sender);
    sendToEmail = removeSpecialChar(sendToEmail);

    String senderDbPath = '$_dbMsgRoot/${chatModel.sender}/$sendToEmail';
    String receiverDbPath = '$_dbMsgRoot/$sendToEmail/${chatModel.sender}';

    await _rtdbRef
        .child(senderDbPath)
        .update({dbMsgTimestampKey: ServerValue.timestamp});
    await _rtdbRef
        .child(receiverDbPath)
        .update({dbMsgTimestampKey: ServerValue.timestamp});

    await _rtdbRef.child(senderDbPath).push().set(chatModel.toJson());
    await _rtdbRef
        .child(receiverDbPath)
        .push()
        .set(chatModel.toJson())
        .onError((error, stackTrace) {
      print('\n\n : error sending msg > $error & $stackTrace');
      CustomSnackBar.showSnackBar(
          globalNavigatorKey.currentContext!, 'ERROR : Message not sent !!!');
    }).then((value) {
      print('\n\n : msg sent successfully');
      DialogWidgets.hideCircularProgressIndicator();
      CustomSnackBar.showSnackBar(
          globalNavigatorKey.currentContext!, 'Message sent successfully !!!');
    });
  }
}
