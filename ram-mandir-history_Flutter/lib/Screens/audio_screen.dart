import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ram_mandir_history_project/components/audio_data.dart';
import 'package:ram_mandir_history_project/Model/audio_model.dart';
import 'package:ram_mandir_history_project/components/audio_card.dart';
import 'package:ram_mandir_history_project/components/audio_cover_photo_card.dart';
import 'package:ram_mandir_history_project/components/audio_player_listview.dart';
import 'package:ram_mandir_history_project/components/player_widget.dart';
import 'package:ram_mandir_history_project/constants.dart';

class AudioScreen extends StatefulWidget {
  AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  // int selectedAudioIdx = 0;
  // AudioModel currentAudio = AudioData.getAudioList[0];

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double width = deviceSize.width;
    double height = deviceSize.height;

    return Scaffold(
      body: Consumer<AudioData>(
        builder: (context, audioData, child) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: width < kMobileWidth ? width : kMobileWidth,
                decoration: width < kMobileWidth ? null : kWebBoxDecor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: width < kMobileWidth ? width : 400,
                        // height: width < kMobileWidth ? null : 300,
                        child: AudioCoverPhotoCard(
                          coverPhotoUrl: audioData
                              .getAudioList[audioData.getCurrentIndex]
                              .coverPhotoUrl,
                          // currentAudio.coverPhotoUrl,
                        )),
                    Card(
                      margin: const EdgeInsets.only(
                          left: 12.0, right: 12.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(audioData
                              .getAudioList[audioData.getCurrentIndex].title),
                          Text(
                              '${audioData.getAudioList[audioData.getCurrentIndex].singer} + ${audioData.getCurrentIndex}'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 220.0,
                      child: ListView.builder(
                          itemCount: audioData.getAudioListLength,
                          itemBuilder: (context, index) {
                            AudioModel audioModel =
                                audioData.getAudioList[index];
                            return AudioCard(
                              audioData: audioModel,
                              cardOnTap: () {
                                // setState(() {
                                //   selectedAudioIdx = index;
                                //   currentAudio = audioModel;
                                // });
                                // audioData.updateCurrentIndex(index);
                                Provider.of<AudioData>(context, listen: false)
                                    .updateCurrentIndex(index);
                                // Provider.of<AudioData>(context, listen: false)
                                //     .updateCurrentAudioSource(index);
                              },
                            );
                          }),
                    ),
                    PlayerWidget(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
