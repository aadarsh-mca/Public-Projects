import 'package:flutter/material.dart';

const kWelcomeScreenRoute = '/';
const kChatListScreenRoute = '/chatListScreen';
const kChatScreenRoute = '/chatScreen';

const kLoggedUserStatusKey = 'loggedUserStatus';
const kLoggedUserDataKey = 'loggedUserData';
const kLoggedUserUidKey = 'loggedUserUid';
const kLoggedUserNameKey = 'loggedUserName';
const kLoggedUserEmailKey = 'loggedUserEmail';

const kDialogSendMsgToEmail = 'sendToEmail';
const kDialogSendMsgBody = 'sendMsgBody';

const kLoginLogoPath = 'assets/images/humankey_logo.png';

const kTitle500TextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

const kTitle900TextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w900,
);

const double kDialogMaxWidth = 420.0;
var kDialogTextStyle = TextStyle(
  color: Colors.blueAccent[700],
  fontWeight: FontWeight.w500,
  fontSize: 22.0,
);

const kToggleButtonTextStyle = TextStyle(fontWeight: FontWeight.w500);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const InputDecoration kInputFieldDecorLightBlueAccent = InputDecoration(
  labelStyle: TextStyle(color: Colors.grey),
  hintStyle: TextStyle(color: Colors.grey),
  prefixIconColor: Colors.lightBlueAccent,
  suffixIconColor: Colors.grey,
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

const InputDecoration kInputFieldDecorBlueAccent = InputDecoration(
  labelStyle: TextStyle(color: Colors.grey),
  hintStyle: TextStyle(color: Colors.grey),
  prefixIconColor: Colors.blueAccent,
  suffixIconColor: Colors.grey,
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  border: OutlineInputBorder(),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
