import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ram_mandir_history_project/Model/audio_model.dart';
import 'package:ram_mandir_history_project/components/player_widget.dart';

/// ChangeNotifier Class to update current playing audio in [PlayerWidget]
class AudioData extends ChangeNotifier {
  /// default Index of audio to be played
  int _currentIndex = 0;

  /// default Source of audio to be played
  String _currentAudioSource = 'ram_aayenge_female_version.mp3';
  bool _isSourceChanged = false;

  int get getCurrentIndex => _currentIndex;
  String get getCurrentAudioSource => _currentAudioSource;
  bool get isSourceChanged => _isSourceChanged;

  void updateIsSourceChanged() {
    _isSourceChanged = !_isSourceChanged;
  }

  void nextAudio() {
    if (_currentIndex < getAudioListLength - 1) {
      updateAudioIndexSource(_currentIndex + 1);
    }
  }

  void previousAudio() {
    if (_currentIndex > 0) {
      updateAudioIndexSource(_currentIndex - 1);
    }
  }

  void updateAudioIndexSource(int newIndex) {
    _isSourceChanged = true;
    _currentIndex = newIndex;
    _currentAudioSource = getAudioList[getCurrentIndex].sourcePath;
    notifyListeners();
  }

  int get getAudioListLength {
    return _audioList.length;
  }

  UnmodifiableListView<AudioModel> get getAudioList {
    return UnmodifiableListView(_audioList);
  }

  final List<AudioModel> _audioList = [
    AudioModel(
      index: 0,
      title: 'Ram Aayenge - Female Version',
      singer: 'Swati Mishra',
      lyricist: 'Late Shyam Sundar Sharma',
      musicLabel: 'T-Series',
      sourcePath: 'ram_aayenge_female_version.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/dWOcoa7UxO73xJdlQDVj00TSJuWArzh31Owhd09feXi3Aas-5WqQILPgImbGjVuTuFYZKIHq-_b7uK4',
    ),
    AudioModel(
      index: 1,
      title: 'Mere Ghar Ram Aaye Hain',
      singer: 'Jubin Nautiyal',
      lyricist: 'Manoj Muntashir',
      musicLabel: 'T-Series',
      sourcePath: 'mere_ghar_ram_aaye_hain.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/FkmpVFcgnZ3kZYB_RP-w2KlR5d7ckgSCjn3BdVzNVGs1m8FEtIYpsYjMwH_Hjj3PT2DrUbChBBIbNjsJow',
    ),
    AudioModel(
      index: 2,
      title: 'Shri Ram Chandra Kripalu Bhajman',
      singer: 'Anuradha Paudwal',
      lyricist: 'Sant Tulsidas',
      musicLabel: 'T-Series',
      sourcePath: 'shri_ram_chandra_kripalu_bhajman.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/Pw7ls0pqU99scN4nIr6sO9cX4b9BMW6WJW0gLD1rEun-vicFmgCpRoyF84mP5hbi4jV57iWubPq8bmyt',
    ),
    AudioModel(
      index: 3,
      title: 'Avadh Mein Laute Hai Shri Ram',
      singer: 'Sonu Nigam',
      lyricist: 'Ashutosh Agnihotri',
      musicLabel: 'T-Series',
      sourcePath: 'avadh_mein_laute_hai_shri_ram.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/rKKufMrS34h3WhLn5Ab2axopjZM-sgPNrKSiflhw-r7CU8QBhrq9oKgd3W-CZP55D4fqxi_Hgab1j-9W',
    ),
    AudioModel(
      index: 4,
      title: 'Ram Aayenge - Male Version',
      singer: 'Vishal Mishra',
      lyricist: 'Manoj Muntashir',
      musicLabel: 'T-Series',
      sourcePath: 'ram_aayenge_male_version.mp3',
      coverPhotoUrl:
          'https://lh3.googleusercontent.com/dWOcoa7UxO73xJdlQDVj00TSJuWArzh31Owhd09feXi3Aas-5WqQILPgImbGjVuTuFYZKIHq-_b7uK4',
    ),
  ];
}
