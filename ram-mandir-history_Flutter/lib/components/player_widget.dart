import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ram_mandir_history_project/components/audio_data.dart';
import 'package:ram_mandir_history_project/components/repeat_playlist.dart';
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
  RepeatPlaylist _repeatStatus = RepeatPlaylist.all;

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
        // getTime(newPosition.inMilliseconds);
        _position = newPosition;
      });
    });

    _completeSubscription = audioPlayer.onPlayerComplete.listen((onComplete) {
      setState(() {
        _position = Duration.zero;
        switch (_repeatStatus) {
          case RepeatPlaylist.none:
            audioPlayer.state = PlayerState.stopped;
            audioPlayer.setSourceAsset(
                Provider.of<AudioData>(context, listen: false)
                    .getCurrentAudioSource);
            break;
          case RepeatPlaylist.one:
            audioPlayer.play(AssetSource(
                Provider.of<AudioData>(context, listen: false)
                    .getCurrentAudioSource));
            // print('\n\n\n\n ${audioPlayer.source}');
            break;
          case RepeatPlaylist.all:
            Provider.of<AudioData>(context, listen: false).playNextAudio();
            break;
        }
        // _position = Duration.zero;
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
                  Text(getFormattedTime(_position)),
                  Text(getFormattedTime(_duration)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    audioData.playShuffledAudio();
                  },
                  icon: const Icon(
                    Icons.shuffle_rounded,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    audioData.playPreviousAudio();
                  },
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (!_isPlaying) {
                      resumeAudio();
                      // audioPlayer
                      //     .play(AssetSource(audioData.getCurrentAudioSource));
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
                    audioData.playNextAudio();
                  },
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    updateLoopPreference();
                  },
                  icon: getRepeatIcon(),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  /// * [Return] a [String] containing [Duration] in user readable format
  // String getFormattedTime(int seconds) {
  //   String str = Duration(seconds: seconds).toString();
  //   return str.split(".")[0].padLeft(8, '0');
  // }
  String getFormattedTime(Duration duration) {
    String seconds =
        ((duration.inMilliseconds ~/ 1000) % 60).toString().padLeft(2, '0');
    String minutes = ((duration.inMilliseconds ~/ 1000 ~/ 60) % 60).toString();
    // print('Position ---> $minutes : $seconds :: $milliseconds');
    return '$minutes:$seconds';
  }

  Icon getRepeatIcon() {
    switch (_repeatStatus) {
      case RepeatPlaylist.none:
        return const Icon(Icons.not_interested_rounded);
      case RepeatPlaylist.one:
        return const Icon(Icons.repeat_one_rounded, color: kSaffronColor);
      case RepeatPlaylist.all:
        return const Icon(Icons.repeat_rounded, color: kSaffronColor);
    }
  }

  /// This will update user preference of looping the playlist
  void updateLoopPreference() {
    setState(() {
      switch (_repeatStatus) {
        case RepeatPlaylist.none:
          _repeatStatus = RepeatPlaylist.one;
          // DisplaySnackBar.showSnackMessage(context, 'Repeat 1');
          break;
        case RepeatPlaylist.one:
          _repeatStatus = RepeatPlaylist.all;
          // DisplaySnackBar.showSnackMessage(context, 'Repeat All');
          break;
        case RepeatPlaylist.all:
          _repeatStatus = RepeatPlaylist.none;
          // DisplaySnackBar.showSnackMessage(context, 'Repeat None');
          break;
      }
    });
  }

  /// Create toast message
  ///
  /// * [Parameter] String message
  // void displaySnackBar(String message) {

  // }

  void resumeAudio() {
    audioPlayer.resume();
  }

  void pauseAudio() {
    audioPlayer.pause();
  }
}
