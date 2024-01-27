import 'dart:async';

import 'package:expense_tracking_app/constants.dart';
import 'package:expense_tracking_app/screens/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

const double _appLogoSize = 200;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('MediaQuery constraints: ${getScreenWidth(context)}');

    print(_animationController.value);

    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, kGettingStartedScreenRoute);
    });
    return Scaffold(
      backgroundColor: kAppThemeColor,
      body: LayoutBuilder(builder: (context, constraints) {
        print('layoutBuilder constraints: $constraints');
        return Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Transform.rotate(
                angle: math.pi,
                child: SvgPicture.asset(
                  kCornerLogoPath,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
            Positioned(
              top: ((constraints.constrainHeight() / 2) - (_appLogoSize / 2)),
              left: ((constraints.constrainWidth() / 2) - (_appLogoSize / 2)),
              child: Hero(
                tag: kAppLogoTag,
                child: Image.asset(kAppLogoPath,
                    width: _appLogoSize, height: _appLogoSize),
              ),
            ),
            Positioned(
              top: (constraints.constrainHeight() / 2 + (_appLogoSize / 3)),
              child: Hero(
                tag: kAppTitleTag,
                child: Text('CIPHERX',
                    style: kAppTitleStyle, textAlign: TextAlign.center),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset(
                kCornerLogoPath,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ],
        );
      }),
    );
  }
}
