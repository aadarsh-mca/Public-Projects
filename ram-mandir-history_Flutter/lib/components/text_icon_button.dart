import 'package:flutter/material.dart';
import 'package:ram_mandir_history_project/constants.dart';

class FloatingTextIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;
  final String label;

/// Create a clickable widget containing an [Icon] and a [Text]
/// * [Required] VoidCallback onTap()
/// * [Required] Icon widget
  const FloatingTextIconButton({required this.onTap, required this.icon, this.label = 'Button', super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kSaffronColor,
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
