import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.text,
    required this.color,
    required this.onPressed,
    super.key,
    this.textColor = Colors.white,
    this.rounded = 18,
  });
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final Color textColor;
  final double rounded;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 9,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
