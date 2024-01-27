import 'package:flutter/material.dart';

class PaddingButton extends StatelessWidget {
  EdgeInsetsGeometry padding;
  Color color;
  double elevation;
  double radius;
  VoidCallback onPress;
  double minWidth;
  double height;
  String btnText;
  bool disableButton;

  PaddingButton({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.color = const Color(0xFF40C4FF),
    this.elevation = 5.0,
    this.radius = 20.0,
    required this.onPress,
    this.minWidth = 200.0,
    this.height = 40.0,
    this.btnText = 'Button',
    this.disableButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        elevation: disableButton ? 0.0 : elevation,
        color: disableButton ? Colors.grey.shade400 : color,
        borderRadius: BorderRadius.circular(radius),
        child: MaterialButton(
          onPressed: disableButton ? null : onPress,
          minWidth: minWidth,
          height: height,
          child: Text(
            btnText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
