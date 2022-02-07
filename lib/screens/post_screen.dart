import 'package:flutter/material.dart';

class PostScreenArgs {
  final int postId;

  PostScreenArgs({
    required this.postId,
  });
}

class PostScreen extends StatelessWidget {
  static const routeName = 'post';

  const PostScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostScreenArgs routeArgs = ModalRoute.of(context)!.settings.arguments as PostScreenArgs;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Post Screen ${routeArgs.postId}'),
        ),
      ),
    );
  }
}
