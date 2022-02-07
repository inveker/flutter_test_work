import 'package:flutter/material.dart';

class AlbumsScreenArgs {
  final int userId;

  AlbumsScreenArgs({
    required this.userId,
  });
}

class AlbumsScreen extends StatelessWidget {
  static const routeName = 'albums';

  const AlbumsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlbumsScreenArgs routeArgs = ModalRoute.of(context)!.settings.arguments as AlbumsScreenArgs;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Albums Screen ${routeArgs.userId}'),
        ),
      ),
    );
  }
}
