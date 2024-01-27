import 'package:firebase_database/firebase_database.dart';
import 'package:flash_chat_flutter_app_challenge/components/dialog_widgets.dart';
import 'package:flash_chat_flutter_app_challenge/constants.dart';
import 'package:flash_chat_flutter_app_challenge/models/chat_list_model.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_service/database_service.dart';

class ChatListData extends StatefulWidget {
  const ChatListData({super.key});

  @override
  State<ChatListData> createState() => _ChatListDataState();
}

class _ChatListDataState extends State<ChatListData> {
  late final DatabaseReference _streamOfMsgList;

  @override
  void initState() {
    super.initState();
    _streamOfMsgList = FirebaseDatabaseService.getAllChatList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _streamOfMsgList.orderByChild(dbMsgTimestampKey).onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return DialogWidgets.showProgressIndicator();
        } else {
          List<ChatListModel> listOfChatListModel = [];
          final children = snapshot.data!.snapshot.children;
          print('children : ${children.length}');
          for (var child in children) {
            String url = '${getMsgDbPath()}/${child.key}';
            listOfChatListModel
                .add(ChatListModel(email: child.key.toString(), dbUrl: url));
          }
          listOfChatListModel = listOfChatListModel.reversed.toList();

          return ListView.builder(
              itemCount: listOfChatListModel.length,
              itemBuilder: (listContext, index) {
                ChatListModel modelData = listOfChatListModel[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(modelData.email.toString()),
                    trailing: Icon(Icons.navigate_next_rounded),
                    selectedColor: Colors.lightBlueAccent[100],
                    onTap: () {
                      Navigator.pushNamed(context, kChatScreenRoute,
                          arguments: modelData);
                    },
                  ),
                );
              });
        }
      },
    );
  }
}
