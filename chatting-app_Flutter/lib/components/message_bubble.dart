import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MsgBubble extends StatelessWidget {
  late var timestamp;
  late String msg;
  late String sender;
  bool isSenderMe = false;

  MsgBubble(
      {required this.timestamp,
      required this.msg,
      required this.sender,
      required this.isSenderMe});

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal();
    var dateTime = DateFormat('dd MMM, HH:mm').format(dt);

    return Padding(
      padding: isSenderMe
          ? EdgeInsets.only(left: 80.0, top: 6.0, right: 8.0, bottom: 6.0)
          : EdgeInsets.only(left: 8.0, top: 6.0, right: 80.0, bottom: 6.0),
      child: Column(
        crossAxisAlignment:
            isSenderMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 4.0,
            color: isSenderMe
                ? Colors.lightBlueAccent[400]
                : Colors.blueAccent[400],
            borderRadius: BorderRadius.only(
              topLeft:
                  isSenderMe ? Radius.circular(16.0) : Radius.circular(2.0),
              bottomLeft: Radius.circular(16.0),
              topRight:
                  isSenderMe ? Radius.circular(2.0) : Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
              child: Text(
                msg,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              dateTime,
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
