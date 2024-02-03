import 'package:flutter/material.dart';
import 'package:ram_mandir_history_project/constants.dart';

class TextIconButton extends StatelessWidget {
  VoidCallback onTap;

  TextIconButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kSaffronColor,
          ),
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.music_note_rounded),
              Text('Play Bhajan'),
            ],
          ),
        ),
      ),
    );
  }
}
