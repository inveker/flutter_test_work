import 'package:flutter/material.dart';

class UserScreenArgs {
  final int userId;

  UserScreenArgs({
    required this.userId,
  });
}

class UserScreen extends StatelessWidget {
  static const routeName = 'user';

  const UserScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserScreenArgs routeArgs = ModalRoute.of(context)!.settings.arguments as UserScreenArgs;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('User Screen ${routeArgs.userId}'),
        ),
      ),
    );
  }
}
