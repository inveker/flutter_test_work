import 'package:flutter/material.dart';

class ShowMoreButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ShowMoreButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Show more'),
      onPressed: onPressed,
    );
  }
}
