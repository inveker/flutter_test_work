import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final String title;

  const FieldTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black26,
      ),
    );
  }
}
