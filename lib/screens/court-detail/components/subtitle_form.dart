import 'package:flutter/material.dart';

class SubtitleForm extends StatelessWidget {
  final String title;
  const SubtitleForm({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: size.height * 0.02,
        bottom: size.height * 0.02,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
