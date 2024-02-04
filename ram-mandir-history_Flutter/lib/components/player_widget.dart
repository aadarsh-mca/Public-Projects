import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ram_mandir_history_project/components/audio_data.dart';
import 'package:ram_mandir_history_project/constants.dart';

class PlayerWidget extends StatefulWidget {

  /// Create an audio player widget
  /// Used to play/pause and control audio player
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

/// Create an instance of [StreamSubscription] used to listen changes in [Duration] of audio player
  StreamSubscription? _durationSubscription;
/// Create an instance of [StreamSubscription] used to listen changes in [Position] of audio player
  StreamSubscription? _positionSubscription;
/// Create an instance of [StreamSubscription] used to listen changes in [State] of audio player
  StreamSubscription? _stateChangedSubscription;
/// Create an instance of [StreamSubscription] used to listen changes in [Completion] of audio player
  StreamSubscription? _completeSubscription;

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer.setSourceAsset(
        Provider.of<AudioData>(context, listen: false).getCurrentAudioSource);

    _stateChangedSubscription =
        audioPlayer.onPlayerStateChanged.listen((newState) {
      setState(() {
        _isPlaying = newState == PlayerState.playing;
      });
    });

    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _positionSubscription = audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    _completeSubscription = audioPlayer.onPlayerComplete.listen((onComplete) {
      setState(() {
        _position = Duration.zero;
        Provider.of<AudioData>(context, listen: false).nextAudio();
      });
    });
  }

  /// Disposing all the instance of :
  /// * [AudioPlayer] and
  /// * [StreamSubscription]
  @override
  void dispose() {
    audioPlayer.dispose();
    _stateChangedSubscription?.cancel();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _completeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// Created a [Consumer<AudioData>] builder to listen changes occurred in [ChangeNotifier] class
    return Consumer<AudioData>(builder: (context, audioData, child) {

      /// This will be called when 
      /// * user change audio from [Previous], [Next] [Button] provided in [PlayerWidget] class, or
      /// * user change audio from [ListView.builder] provided in [AudioScreen] class
      if (audioData.isSourceChanged) {
        audioPlayer.play(AssetSource(audioData.getCurrentAudioSource));
        Provider.of<AudioData>(context, listen: false).updateIsSourceChanged();
        print('source changed : ${audioData.isSourceChanged}');
      }

      /// Create a widget to control audio player
      return Container(
        child: Column(
          children: [

            /// Create a [SeekBar] to manually control the position of [AudioPlayer]
            Slider(
              activeColor: kSaffronColor,
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.toDouble(),
              onChanged: (newPosition) {
                audioPlayer.seek(Duration(seconds: newPosition.toInt()));
                audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getFormattedTime(_position.inSeconds)),
                  Text(getFormattedTime(_duration.inSeconds)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    audioData.previousAudio();
                  },
                  icon: Icon(
                    Icons.skip_previous_rounded,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (!_isPlaying) {
                      audioPlayer
                          .play(AssetSource(audioData.getCurrentAudioSource));
                    } else {
                      pauseAudio();
                    }
                  },
                  icon: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 50,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    audioData.nextAudio();
                  },
                  icon: Icon(
                    Icons.skip_next_rounded,
                    size: 35,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

/// * [Return] a [String] containing [Duration] in user readable format
  String getFormattedTime(int seconds) {
    String str = Duration(seconds: seconds).toString();
    return str.split(".")[0].padLeft(8, '0');
  }

  void resumeAudio() {
    audioPlayer.resume();
  }

  void pauseAudio() {
    audioPlayer.pause();
  }
}
