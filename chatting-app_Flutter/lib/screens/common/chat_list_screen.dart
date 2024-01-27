import 'package:firebase_database/firebase_database.dart';
import 'package:flash_chat_flutter_app_challenge/components/dialog_widgets.dart';
import 'package:flash_chat_flutter_app_challenge/models/chat_model.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/screen_size.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/welcome_screen.dart';
import 'package:flash_chat_flutter_app_challenge/services/firebase_service/database_service.dart';
import 'package:flash_chat_flutter_app_challenge/services/user_service.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../global_variable.dart';
import '../../services/firebase_service/firebase_auth_service.dart';
import '../mobile/mob_chat_list_screen.dart';
import '../tablet/tab_chat_list_screen.dart';
import '../web/web_chat_list_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late Future<Map<String, dynamic>> _getLoggedInUser;

  @override
  void initState() {
    super.initState();
    _getLoggedInUser = UserService.getLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    // print('chat list screen :  ${getLoggedUserEmail()}');
    final double _width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: _getLoggedInUser,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return DialogWidgets.showProgressIndicator();
          } else if (snapshot.hasData &&
              snapshot.data?[kLoggedUserStatusKey] == true) {
            setLoggedUserStatus(snapshot.data?[kLoggedUserStatusKey]);
            setLoggedUserEmail(snapshot.data?[kLoggedUserEmailKey]);

            if (_width < kTabletMinWidth) {
              return MobChatListScreen();
            } else if (_width >= kTabletMinWidth && _width < kWebMinWidth) {
              return TabChatListScreen();
            } else {
              return WebChatListScreen();
            }
          } else {
            return WelcomeScreen();
          }
        });
  }
}

mixin ChatListScreenMixin<T extends StatefulWidget> on State<T> {
  late final DatabaseReference _streamOfMsgList;

  @override
  void initState() {
    super.initState();
    _streamOfMsgList = FirebaseDatabaseService.getAllChatList();
  }

  AppBar getAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          showSendNewMsgDialog();
        },
        icon: Icon(
          Icons.add_comment_rounded,
          color: Colors.white,
        ),
      ),
      title: Text(
        '${getLoggedUserEmail()}'.toUpperCase(),
        style: const TextStyle(fontSize: 17.0, color: Colors.white),
      ),
      backgroundColor: Colors.lightBlueAccent[400],
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async {
            await FirebaseAuthService(context: context).logoutUser();
            Navigator.pushNamedAndRemoveUntil(
                context, kWelcomeScreenRoute, (route) => false);
          },
          icon: const Icon(
            Icons.exit_to_app_rounded,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  void showSendNewMsgDialog() {
    Size _dSize = MediaQuery.of(context).size;
    String _sendMsgToEmail = '';
    String _sendMsgBody = '';
    bool _emailInputError = false;
    bool _msgInputError = false;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(builder: (builderContext, setState) {
            return Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Dialog(
                    insetPadding: EdgeInsets.all(16.0),
                    child: Container(
                      width: _dSize.width < 600
                          ? _dSize.width * 0.9
                          : kDialogMaxWidth,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'New Message',
                            style: kDialogTextStyle,
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (data) {
                              _sendMsgToEmail = data;
                              setState(() {
                                _emailInputError =
                                    _sendMsgToEmail.isEmpty ? true : false;
                              });
                            },
                            decoration: kInputFieldDecorBlueAccent.copyWith(
                              label: Text('Send To Email'),
                              icon: Icon(Icons.email_rounded),
                              iconColor: Colors.blueAccent[700],
                              errorText: _emailInputError ? 'Required' : null,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            onChanged: (data) {
                              _sendMsgBody = data;
                              setState(() {
                                _msgInputError =
                                    _sendMsgBody.isEmpty ? true : false;
                              });
                            },
                            maxLines: 5,
                            decoration: kInputFieldDecorBlueAccent.copyWith(
                              label: Text('Message'),
                              icon: Icon(Icons.message_rounded),
                              iconColor: Colors.blueAccent[700],
                              errorText: _msgInputError ? 'Required' : null,
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  icon: Icon(Icons.close_rounded,
                                      color: Colors.red),
                                  label: Text('Close',
                                      style: TextStyle(color: Colors.red))),
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    setState(() async {
                                      if (_sendMsgToEmail.isNotEmpty &&
                                          _sendMsgBody.isNotEmpty) {
                                        ChatModel chatData = ChatModel(
                                          sender: getLoggedUserEmail(),
                                          content: _sendMsgBody,
                                        );
                                        Navigator.pop(dialogContext);
                                        await FirebaseDatabaseService
                                            .sendMsgToEmail(
                                                chatData, _sendMsgToEmail);
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.send_rounded,
                                      color: Colors.blueAccent),
                                  label: Text('Send',
                                      style:
                                          TextStyle(color: Colors.blueAccent))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

}
