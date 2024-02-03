import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ram_mandir_history_project/components/audio_data.dart';
import 'package:ram_mandir_history_project/Screens/audio_screen.dart';
import 'package:ram_mandir_history_project/Screens/timeline_screen.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  // return ChangeNotifierProvider(create: (context) {});
  return runApp(ChangeNotifierProvider<AudioData>(
      create: (context) => AudioData(), child: RamMandirHistory()));
}

class RamMandirHistory extends StatelessWidget {
  const RamMandirHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      home: TimelineScreen(),
    );
  }
}