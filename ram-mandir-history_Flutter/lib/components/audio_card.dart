import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ram_mandir_history_project/Model/audio_model.dart';
import 'package:ram_mandir_history_project/components/audio_data.dart';
import 'package:ram_mandir_history_project/constants.dart';

class AudioCard extends StatelessWidget {
  AudioModel audioData;
  VoidCallback cardOnTap;

  /// Create a widget to display all the detail of audio
  /// Also show the current playing audio
  /// * [required] [AudioData]
  /// * [required] [cardOnTap]
  AudioCard({required this.audioData, required this.cardOnTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardOnTap,
      child: Card(
        color:
            audioData.index == Provider.of<AudioData>(context).getCurrentIndex
                ? Colors.transparent
                : Colors.white,
        elevation:
            audioData.index == Provider.of<AudioData>(context).getCurrentIndex
                ? 1.0
                : 3.0,
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Card(
                elevation: 10.0,
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
      ),
    );
  }
}
