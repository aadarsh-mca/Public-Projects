import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ram_mandir_history_project/components/audio_data.dart';
import 'package:provider/provider.dart';
import 'package:ram_mandir_history_project/Model/audio_model.dart';
import 'package:ram_mandir_history_project/main.dart';

class PlayerWidget extends StatefulWidget {
  // int audioIndex;
  // AudioPlayer audioPlayer;
  // String audioPath;

  //required this.audioIndex,
  PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  // AudioData get getAudioDataClass {
  //   return Provider.of<AudioData>(context, listen: false);
  // }
  //

  int get getAudioListLength {
    return Provider.of<AudioData>(context, listen: false).getAudioListLength;
  }

  int get getCurrentPlayingIndex {
    return Provider.of<AudioData>(context, listen: true).getCurrentIndex;
  }

  String get getCurrentAudioSource {
    return Provider.of<AudioData>(context, listen: true).getCurrentAudioSource;
  }

  // AudioModel get getCurrentAudio {
  //   return Provider.of<AudioData>(context, listen: false)
  //       .getAudioList[getCurrentPlayingIndex];
  // }

  AudioPlayer player = AudioPlayer();
  AudioPlayer get getCurrentAudioPlayer {
    return player;
  }

  // AssetSource get getCurrentAudioSource {
  //   return AssetSource(getCurrentAudio.sourcePath);
  // }

  PlayerState? _playerState;
  bool get _isPlaying {
    return _playerState == PlayerState.playing;
  }

  bool get _isPaused {
    return _playerState == PlayerState.paused;
  }

  bool get _isStopped {
    return _playerState == PlayerState.stopped;
  }

  late StreamSubscription _durationSubscription;
  late StreamSubscription _positionSubscription;
  late StreamSubscription _stateChangedSubscription;

  late Duration _duration;
  Duration _position = Duration(minutes: 0, seconds: 0);

  // @override
  // void setState(VoidCallback fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    initValue();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _durationSubscription.cancel();
    _stateChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // audioPlayer = Provider.of<AudioData>(context, listen: true)
    //     .getAudioList[getCurrentPlayingIndex]
    //     .audioPlayer;
    // initValue(index: getCurrentPlayingIndex, listen: true);

    return Container(
      child: Column(
        children: [
          Slider(
            value: 0.0,
            onChanged: (newPosition) {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0:00'),
                Text('0:00'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  playPreviousAudio();
                },
                icon: Icon(
                  Icons.skip_previous_rounded,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (_isPlaying) {
                    pauseAudio();
                  } else {
                    resumeAudio();
                  }
                  // if (_isStopped) {
                  //   await playNewAudio();
                  // } else if (_isPlaying) {
                  //   await pauseAudio();
                  // } else if (_isPaused) {
                  //   await resumeAudio();
                  // }
                  // playNewAudio();
                },
                icon: Icon(
                  _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  playNextAudio();
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
  }

  void playNextAudio() {
    // setState(() {
    if (getCurrentPlayingIndex < getAudioListLength - 1) {
      // disposeValue();
      Provider.of<AudioData>(context, listen: false)
          .updateCurrentIndex(getCurrentPlayingIndex + 1);
      // // getAudioDataClass.updateCurrentIndex();
      // getCurrentAudioSource = AssetSource(getCurrentAudio.sourcePath);
      // playNewAudio();
      // PlayerWidget(audioIndex: getCurrentPlayingIndex + 1);
      getCurrentAudioPlayer.setSourceAsset(
          Provider.of<AudioData>(context, listen: false).getCurrentAudioSource);
    }
    // });
  }

  void playPreviousAudio() async {
    if (getCurrentPlayingIndex > 0) {
      // await disposeValue();
      Provider.of<AudioData>(context, listen: false)
          .updateCurrentIndex(getCurrentPlayingIndex - 1);
      // getAudioDataClass.updateCurrentIndex();
      // getCurrentAudioSource = AssetSource(getCurrentAudio.sourcePath);
      // playNewAudio();
      // PlayerWidget(audioIndex: getCurrentPlayingIndex - 1);
    }
  }

  Future<void> playNewAudio() async {
    // , position: _position
    await getCurrentAudioPlayer.play(AssetSource(
        Provider.of<AudioData>(context, listen: false).getCurrentAudioSource));
  }

  Future<void> resumeAudio() async {
    await getCurrentAudioPlayer.resume();
  }

  Future<void> pauseAudio() async {
    await getCurrentAudioPlayer.pause();
  }

  void disposeValue() {
    if (_isPlaying || _isPaused || _isStopped) {
      _positionSubscription.cancel();
      _durationSubscription.cancel();
      _stateChangedSubscription.cancel();
    }
  }

  void initValue() {
    // audioPlayer = Provider.of<AudioData>(context, listen: listen)
    //     .getAudioList[index]
    //     .audioPlayer;
    // source = AssetSource(getCurrentAudio.sourcePath);
    // _playerState = audioPlayer.state;
    //
    // // audioPlayer.getDuration().then(
    // //       (value) => setState(() {
    // //         _duration = value!;
    // //       }),
    // //     );
    // // audioPlayer.getCurrentPosition().then(
    // //       (value) => setState(() {
    // //         _position = value!;
    // //       }),
    // //     );

    _stateChangedSubscription =
        getCurrentAudioPlayer.onPlayerStateChanged.listen((newState) {
      setState(() {
        _playerState = newState;
        print('Player Widget - isStopped : $_isStopped');
        print('Player Widget - isPlaying : $_isPlaying');
        print('Player Widget - isPaused : $_isPaused');
      });
    });
    print('Player Widget - isStopped : $_isStopped');
    print('Player Widget - isPlaying : $_isPlaying');
    print('Player Widget - isPaused : $_isPaused');

    _durationSubscription =
        getCurrentAudioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
        // print('duration : $_duration');
      });
    });

    _positionSubscription =
        getCurrentAudioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
        // print('position : $_position');
      });
    });
  }
}
// }
