import 'package:flutter/material.dart';

class InputContainerForm extends StatelessWidget {
  final bool showError;
  final List<Widget> children;
  const InputContainerForm(
      {super.key, required this.showError, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: showError ? Colors.grey : Colors.red,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
