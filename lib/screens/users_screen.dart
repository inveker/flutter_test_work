import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = 'users';

  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Users Screen'),
        ),
      ),
    );
  }
}
