import 'package:expense_tracking_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracking_app/screens/splash_screen.dart';
import 'package:expense_tracking_app/screens/getting_started_screen.dart';
import 'package:expense_tracking_app/screens/user_onboarding_screen.dart';
import 'package:expense_tracking_app/screens/home_screen.dart';
import 'package:expense_tracking_app/screens/expense_screen.dart';
import 'package:expense_tracking_app/screens/income_screen.dart';
import 'package:expense_tracking_app/screens/profile_screen.dart';

void main() {
  runApp(const ExpenseTrackingApp());
}

class ExpenseTrackingApp extends StatelessWidget {
  const ExpenseTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: ,
      initialRoute: kSplashScreenRoute,
      routes: {
        kSplashScreenRoute: (context) => SplashScreen(),
        kGettingStartedScreenRoute: (context) => GettingStartedScreen(),
        kUserOnboardingScreenRoute: (context) => UserOnboardingScreen(),
        kHomeScreenRoute: (context) => HomeScreen(),
        kExpenseScreenRoute: (context) => ExpenseScreen(),
        kIncomeScreenRoute: (context) => IncomeScreen(),
        kProfileScreenRoute: (context) => ProfileScreen(),
      },
    );
  }
}
