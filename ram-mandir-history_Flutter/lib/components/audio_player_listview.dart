// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ram_mandir_history_project/Model/audio_data.dart';
// import 'package:ram_mandir_history_project/Model/audio_model.dart';
// import 'package:ram_mandir_history_project/components/audio_card.dart';
// import 'package:ram_mandir_history_project/components/audio_cover_photo_card.dart';
// import 'package:ram_mandir_history_project/components/player_widget.dart';
// import 'package:ram_mandir_history_project/constants.dart';
//
// class AudioPlayerListView extends StatefulWidget {
//   AudioPlayerListView({super.key});
//
//   @override
//   State<AudioPlayerListView> createState() => _AudioPlayerListViewState();
// }
//
// class _AudioPlayerListViewState extends State<AudioPlayerListView> {
//   int selectedAudioIdx = 0;
//   AudioModel currentAudio = AudioData.getAudioList[0];
//
//   @override
//   Widget build(BuildContext context) {
//     Size deviceSize = MediaQuery.of(context).size;
//     double width = deviceSize.width;
//     double height = deviceSize.height;
//
//     return ChangeNotifierProvider<AudioData>(
//       create: (context) => AudioData(),
//       child: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             width: width < kMobileWidth ? width : kMobileWidth,
//             decoration: width < kMobileWidth ? null : kWebBoxDecor,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                     width: width < kMobileWidth ? width : 400,
//                     // height: width < kMobileWidth ? null : 300,
//                     child: AudioCoverPhotoCard(
//                         coverPhotoUrl: currentAudio.coverPhotoUrl)),
//                 Card(
//                   margin: const EdgeInsets.only(
//                       left: 12.0, right: 12.0, bottom: 8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(currentAudio.title),
//                       Text('${currentAudio.singer} + $selectedAudioIdx'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 220.0,
//                   child: ListView.builder(
//                       itemCount: AudioData.getAudioListLength,
//                       itemBuilder: (context, index) {
//                         AudioModel audioModel = AudioData.getAudioList[index];
//                         return AudioCard(
//                           audioData: audioModel,
//                           cardOnTap: () {
//                             setState(() {
//                               selectedAudioIdx = index;
//                               currentAudio = audioModel;
//                             });
//                           },
//                         );
//                       }),
//                 ),
//                 PlayerWidget(currentIndex: selectedAudioIdx),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // onTap: () {
// // setState(() {
// // currentAudio = audioModel;
// // });
// // },
