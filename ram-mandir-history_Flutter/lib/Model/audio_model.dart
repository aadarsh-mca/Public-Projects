import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioModel {
  String title;
  String singer;
  String lyricist;
  String musicLabel;
  String sourcePath;
  String coverPhotoUrl;
  // AudioPlayer audioPlayer = AudioPlayer();

  AudioModel({
    required this.title,
    required this.singer,
    required this.lyricist,
    required this.musicLabel,
    required this.sourcePath,
    required this.coverPhotoUrl,
  });
}
