import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/post_model.dart';
import 'package:flutter_test_work/widgets/post_preview.dart';
import 'package:flutter_test_work/widgets/preloader.dart';

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
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: FutureBuilder<List<PostModel>>(
          future: ApiJsonPlaceholder.getPosts(routeArgs.userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _PostsList(
                posts: snapshot.data!,
              );
            } else {
              return const Preloader();
            }
          },
        ),
      ),
    );
  }
}


class _PostsList extends StatelessWidget {
  final List<PostModel> posts;

  const _PostsList({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostPreview(post: post);
      },
    );
  }
}
