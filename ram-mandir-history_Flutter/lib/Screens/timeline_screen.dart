import 'package:flutter/material.dart';
import 'package:ram_mandir_history_project/Model/timeline_model.dart';
import 'package:ram_mandir_history_project/Screens/audio_screen.dart';
import 'package:ram_mandir_history_project/components/text_icon_button.dart';
import 'package:ram_mandir_history_project/components/timeline_data.dart';
import 'package:ram_mandir_history_project/constants.dart';
import 'package:timeline_tile/timeline_tile.dart';

const kAppBarTitle = 'Ram Mandir History';
const kAppBarExpandedHeight = 220.0;
const kPlayBhajanText = 'Play Bhajan';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: sygGradient),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: kSaffronColor,
              pinned: true,
              floating: true,
              expandedHeight: kAppBarExpandedHeight,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: kSaffronColor50,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    kAppBarTitle,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                background: Image.asset(
                  kRamMandirImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: TimelineData.getTimelineListLength,
              (context, index) {
                TimelineModel data = TimelineData.getTimelineData[index];
                return TimelineTile(
                  isFirst: data.isFirst,
                  isLast: data.isLast,
                  axis: TimelineAxis.vertical,
                  alignment: TimelineAlign.manual,
                  lineXY: 0.20,
                  indicatorStyle: const IndicatorStyle(
                      indicatorXY: 0.07,
                      indicator: CircleAvatar(
                        backgroundColor: Colors.red,
                      )),
                  startChild: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data.year),
                    ),
                  ),
                  endChild: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            data.showDescription = !data.showDescription;
                          });
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data.descriptionHeadingText),
                                Icon(data.showDescription
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: data.showDescription,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(data.decriptionText),
                                const SizedBox(height: 8.0),
                                data.decriptionImage != null
                                    ? Image.asset(data.decriptionImage!)
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingTextIconButton(
        label: kPlayBhajanText,
        icon: const Icon(Icons.music_note_rounded),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AudioScreen();
          }));
        },
      ),
    );
  }
}
