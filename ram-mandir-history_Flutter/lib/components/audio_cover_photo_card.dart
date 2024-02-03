import 'package:flutter/material.dart';
import 'package:ram_mandir_history_project/constants.dart';

class AudioCoverPhotoCard extends StatelessWidget {
  String coverPhotoUrl;

  AudioCoverPhotoCard({required this.coverPhotoUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.all(24.0),
      elevation: 10.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          // width: _deviceSize.width * 0.8,
          // height: _deviceSize.height * 0.5,
          fit: BoxFit.fitWidth,
          image: NetworkImage(coverPhotoUrl),
          placeholder: AssetImage(kImagePlaceholder),
        ),
      ),
    );
  }
}
