import 'dart:collection';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ram_mandir_history_project/Model/audio_model.dart';

class AudioData extends ChangeNotifier {
  // late BuildContext context;
  // set context() {}

  int _currentIndex = 0;
  String _currentAudioSource = 'mere_ghar_ram_aaye_hain.mp3';

  int get getCurrentIndex => _currentIndex;
  String get getCurrentAudioSource => _currentAudioSource;

  void updateCurrentIndex(int newIndex) {
    _currentIndex = newIndex;
    _currentAudioSource = getAudioList[getCurrentIndex].sourcePath;
    notifyListeners();
  }

  void updateCurrentAudioSource(int newIndex) {
    _currentAudioSource = getAudioList[getCurrentIndex].sourcePath;
    notifyListeners();
  }

  final List<AudioModel> _audioList = [
    AudioModel(
      title: 'Mere Ghar Ram Aaye Hain',
      singer: 'Jubin Nautiyal',
      lyricist: 'Manoj Muntashir',
      musicLabel: 'T-Series',
      sourcePath: 'mere_ghar_ram_aaye_hain.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/FkmpVFcgnZ3kZYB_RP-w2KlR5d7ckgSCjn3BdVzNVGs1m8FEtIYpsYjMwH_Hjj3PT2DrUbChBBIbNjsJow',
      // audioPlayer: AudioPlayer(),
    ),
    AudioModel(
      title: 'Shri Ram Chandra Kripalu Bhajman',
      singer: 'Anuradha Paudwal',
      lyricist: 'Sant Tulsidas',
      musicLabel: 'T-Series',
      sourcePath: 'shri_ram_chandra_kripalu_bhajman.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/Pw7ls0pqU99scN4nIr6sO9cX4b9BMW6WJW0gLD1rEun-vicFmgCpRoyF84mP5hbi4jV57iWubPq8bmyt',
      // audioPlayer: AudioPlayer(),
    ),
    AudioModel(
      title: 'Avadh Mein Laute Hai Shri Ram',
      singer: 'Sonu Nigam',
      lyricist: 'Ashutosh Agnihotri',
      musicLabel: 'T-Series',
      sourcePath: 'avadh_mein_laute_hai_shri_ram.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/rKKufMrS34h3WhLn5Ab2axopjZM-sgPNrKSiflhw-r7CU8QBhrq9oKgd3W-CZP55D4fqxi_Hgab1j-9W',
      // audioPlayer: AudioPlayer(),
    ),
    AudioModel(
      title: 'Ram Aayenge - Male Version',
      singer: 'Vishal Mishra',
      lyricist: 'Manoj Muntashir',
      musicLabel: 'T-Series',
      sourcePath: 'ram_aayenge_male_version.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/dWOcoa7UxO73xJdlQDVj00TSJuWArzh31Owhd09feXi3Aas-5WqQILPgImbGjVuTuFYZKIHq-_b7uK4',
      // audioPlayer: AudioPlayer(),
    ),
    AudioModel(
      title: 'Ram Aayenge - Female Version',
      singer: 'Swati Mishra',
      lyricist: 'Late Shyam Sundar Sharma',
      musicLabel: 'T-Series',
      sourcePath: 'ram_aayenge_female_version.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/dWOcoa7UxO73xJdlQDVj00TSJuWArzh31Owhd09feXi3Aas-5WqQILPgImbGjVuTuFYZKIHq-_b7uK4',
      // audioPlayer: AudioPlayer(),
    ),
  ];

  int get getAudioListLength {
    return _audioList.length;
  }

  UnmodifiableListView<AudioModel> get getAudioList {
    return UnmodifiableListView(_audioList);
  }
}
