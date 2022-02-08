import 'package:flutter/material.dart';

class Preloader extends StatelessWidget {
  final Color bgColor;

  const Preloader({
    Key? key,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
