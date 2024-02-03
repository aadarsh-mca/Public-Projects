import 'package:flutter/material.dart';
import 'package:ram_mandir_history_project/Model/audio_model.dart';
import 'package:ram_mandir_history_project/constants.dart';

class AudioCard extends StatelessWidget {
  AudioModel audioData;
  VoidCallback cardOnTap;

  AudioCard({required this.audioData, required this.cardOnTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardOnTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Card(
              elevation: 5.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  width: 50.0,
                  fit: BoxFit.fill,
                  image: NetworkImage(audioData.coverPhotoUrl),
                  placeholder: AssetImage(kImagePlaceholder),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(audioData.title, style: kAudioTitleStyle),
                Text(
                  '${audioData.singer}, ${audioData.lyricist}',
                  style: kAudioMetadataStyle,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
