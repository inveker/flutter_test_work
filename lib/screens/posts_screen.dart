import 'package:flutter/material.dart';

class PostsScreenArgs {
  final int userId;

  PostsScreenArgs({
    required this.userId,
  });
}

class PostsScreen extends StatelessWidget {
  static const routeName = 'posts';

  const PostsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostsScreenArgs routeArgs = ModalRoute.of(context)!.settings.arguments as PostsScreenArgs;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Posts Screen ${routeArgs.userId}'),
        ),
      ),
    );
  }
}
