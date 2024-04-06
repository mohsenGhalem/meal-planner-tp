import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  const MyTextButton({
    super.key,
    this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: Colors.blue),
      ),
    );
  }
}
