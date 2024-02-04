import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ram_mandir_history_project/components/audio_data.dart';
import 'package:ram_mandir_history_project/Screens/timeline_screen.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  return runApp(ChangeNotifierProvider<AudioData>(
      create: (context) => AudioData(), child: const RamMandirHistory()));
}

class RamMandirHistory extends StatelessWidget {
  const RamMandirHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      home: const TimelineScreen(),
      // home: AudioScreen(),
    );
  }
}
