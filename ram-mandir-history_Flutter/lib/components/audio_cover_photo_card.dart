import 'package:flutter/material.dart';
import 'package:ram_mandir_history_project/constants.dart';

class AudioCoverPhotoCard extends StatelessWidget {
  String coverPhotoUrl;

  /// Create a widget to show a cover photo while playing bhajan
  /// * [required] Photo Url
  AudioCoverPhotoCard({required this.coverPhotoUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      margin: EdgeInsets.all(24.0),
      elevation: 15.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(coverPhotoUrl),
          placeholder: AssetImage(kImagePlaceholder),
        ),
      ),
    );
  }
}
