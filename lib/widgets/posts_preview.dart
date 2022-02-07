import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/post_model.dart';
import 'package:flutter_test_work/screens/posts_screen.dart';
import 'package:flutter_test_work/widgets/post_preview.dart';
import 'package:flutter_test_work/widgets/preloader.dart';
import 'package:flutter_test_work/widgets/show_more_button.dart';

class PostsPreview extends StatelessWidget {
  final int userId;
  final int count;

  const PostsPreview({
    Key? key,
    required this.userId,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future: ApiJsonPlaceholder.getPosts(userId, count: count),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _PostsPreview(
            posts: snapshot.data!,
            userId: userId,
          );
        } else {
          return const Preloader();
        }
      },
    );
  }
}

class _PostsPreview extends StatelessWidget {
  final List<PostModel> posts;
  final int userId;

  const _PostsPreview({
    required this.posts,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var post in posts)
          PostPreview(
            post: post,
          ),
        ShowMoreButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              PostsScreen.routeName,
              arguments: PostsScreenArgs(userId: userId),
            );
          },
        ),
      ],
    );
  }
}