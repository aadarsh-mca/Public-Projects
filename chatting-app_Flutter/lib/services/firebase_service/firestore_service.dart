import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter_app_challenge/components/message_bubble.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../global_variable.dart';

const firestoreDoc1Key_msgDB = 'messages';
// final firestoreDoc2Key_loggedUser = loggedUserData[kLoggedUserEmailKey];
const firestoreDataMsgKey = 'message';
const firestoreDataSenderKey = 'Sender';

/// messages >> uid/email (all created user data) >>
/// uid/email (list of all frnds) >> auto id (list of all msg) >>
/// particular msg

class FirestoreService {
  static var _firestore = FirebaseFirestore.instance;

  static dynamic getAllChatList() {
    String allChatUrl = '$firestoreDoc1Key_msgDB/${getLoggedUserEmail()}/';
    return FutureBuilder(
        future: _firestore.collectionGroup(getLoggedUserEmail()).get(),
        // .collection(firestoreDoc1Key_msgDB)
        // .doc(firestoreDoc2Key_loggedUser)
        // .doc(allChatUrl)
        // .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return CircularProgressIndicator();
          } else if (snapshots.hasError) {
            print('error found : ${snapshots.error}');
            return Container();
          } else {
            List<Widget> chatList = [];

            final chatDocuments = snapshots.data?.docs;
            for (var docs in chatDocuments!) {
              print('\n\n\n here is the data : ${docs}');
            }

            return Expanded(
              child: ListView(
                children: chatList,
              ),
            );
          }
        });
  }

  Widget getMessages(String chatWithName) {
    /// messages/ test1@gmail.com/ test@example.com
    String chatUrl =
        '$firestoreDoc1Key_msgDB/${getLoggedUserEmail()}/$chatWithName';
    return StreamBuilder(
        stream: _firestore.collection(chatUrl).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: 30.0,
              width: 30.0,
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          } else {
            List<Widget> msgList = [];

            final msgDocuments = snapshot.data?.docs;
            for (var msgDoc in msgDocuments!) {
              String msg = msgDoc[firestoreDataMsgKey];
              String sender = msgDoc[firestoreDataSenderKey];

              msgList.add(MsgBubble(
                timestamp: 1779038079908,
                msg: msg,
                sender: sender,
                isSenderMe: sender.trim() == getLoggedUserEmail().trim(),
              ));
            }
            return Expanded(
              child: ListView(
                children: msgList,
              ),
            );
          }
        });
  }
}
