import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double kMobileWidth = 450;

Color kSaffronColor = Color(0xFFFF7722);
Color kNavyBlueColor = Color(0xFF06038D);
Color kGreenColor = Color(0xFF046A38);
Color kSaffronColor50 = Color(0x80FF7722);
const kRamMandirImage = 'assets/images/ram_mandir_picture.jpg';
const kImagePlaceholder = 'assets/images/image_placeholder.png';

const kAudioTitleStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

const kAudioMetadataStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.italic,
);

LinearGradient sygGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[kSaffronColor, Colors.yellow, Colors.lightGreen]);

BoxDecoration kWebBoxDecor = BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  border: Border.all(
    color: Colors.grey.shade300,
  ),
);
