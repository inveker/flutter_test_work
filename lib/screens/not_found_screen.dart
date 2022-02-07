import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  static const routeName = 'not_found';

  const NotFoundScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Not found'),
        ),
      ),
    );
  }
}
