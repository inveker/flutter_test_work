import 'package:flutter/material.dart';
import 'package:flutter_test_work/models/post_model.dart';
import 'package:flutter_test_work/screens/post_screen.dart';

class PostPreview extends StatelessWidget {
  final PostModel post;

  const PostPreview({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          post.title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          post.body,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          Navigator.of(context).pushNamed(
            PostScreen.routeName,
            arguments: PostScreenArgs(postId: post.id),
          );
        },
      ),
    );
  }
}
