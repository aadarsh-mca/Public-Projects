import 'package:expense_tracking_app/screens/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'package:expense_tracking_app/constants.dart';

const double _appLogoSize = 100.0;

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppThemeColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
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
              top: (constraints.constrainHeight() * 0.08),
              left: (constraints.constrainWidth() * 0.08),
              width: _appLogoSize,
              height: _appLogoSize,
              child: Hero(
                tag: kAppLogoTag,
                child: Image.asset(
                  kAppLogoPath,
                ),
              ),
            ),
            Positioned(
              bottom: (constraints.constrainHeight() * 0.14),
              left: (constraints.constrainWidth() * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to', style: kAppTitleStyle),
                  Row(
                    children: [
                      Hero(
                        tag: kAppTitleTag,
                        child: Text('CIPHERX',
                            style: kAppTitleStyle, textAlign: TextAlign.left),
                      ),
                      SizedBox(width: constraints.constrainWidth() * 0.18),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              kUserOnboardingScreenRoute, (route) => false);
                        },
                        icon: Icon(
                          Icons.forward_rounded,
                          size: 60.0,
                        ),
                        color: Colors.white,
                      )
                    ],
                  ),
                  Text(
                    'Best way to track your expenses....',
                    style: kSmallTextStyle,
                  ),
                ],
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
