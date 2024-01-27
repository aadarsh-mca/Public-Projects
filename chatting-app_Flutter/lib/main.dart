import 'package:flash_chat_flutter_app_challenge/screens/common/chat_list_screen.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/chat_screen.dart';
import 'package:flash_chat_flutter_app_challenge/screens/common/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_flutter_app_challenge/firebase_options.dart';
import 'constants.dart';

// void main() => runApp(FlashChat());

final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .whenComplete(() {
    print('main(): ${DateTime.now().microsecondsSinceEpoch}');
  });
  // FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: globalNavigatorKey,
        initialRoute: kWelcomeScreenRoute,
        routes: {
          kWelcomeScreenRoute: (context) => WelcomeScreen(),
          kChatListScreenRoute: (context) => ChatListScreen(),
          kChatScreenRoute: (context) => ChatScreen(),
        });
  }
}
