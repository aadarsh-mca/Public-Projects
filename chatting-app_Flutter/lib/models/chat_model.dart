import 'package:firebase_database/firebase_database.dart';
import 'package:flash_chat_flutter_app_challenge/services/firebase_service/database_service.dart';

class ChatModel {
  dynamic timestamp = ServerValue.timestamp;
  String sender;
  String content;

  ChatModel({this.timestamp, required this.sender, required this.content});

  dynamic toJson() {
    return {
      dbMsgTimestampKey: ServerValue.timestamp,
      dbMsgContentKey: content,
      dbMsgSenderKey: sender,
    };
  }

  factory ChatModel.fromSnapshot(Map<dynamic, dynamic> snapshotData) {
    return ChatModel(
      timestamp: snapshotData[dbMsgTimestampKey],
      content: snapshotData[dbMsgContentKey],
      sender: snapshotData[dbMsgSenderKey],
    );
  }
}
