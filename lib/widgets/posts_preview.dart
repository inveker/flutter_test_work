import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/post_model.dart';
import 'package:flutter_test_work/screens/post_screen.dart';
import 'package:flutter_test_work/screens/posts_screen.dart';
import 'package:flutter_test_work/widgets/preloader.dart';
import 'package:flutter_test_work/widgets/props_widget.dart';

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
          return _PostsPreviewProps(
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

class _PostsPreviewProps extends PropsWidget {
  final List<PostModel> posts;
  final int userId;

  _PostsPreviewProps({
    required this.posts,
    required this.userId,
  }) : super(child: _PostsPreview());
}

class _PostsPreview extends StatelessWidget {
  const _PostsPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final props = context.props<_PostsPreviewProps>();
    final posts = props.posts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var post in posts)
          _PostPreview(
            post: post,
          ),
        _ShowMoreButton(),
      ],
    );
  }
}

class _ShowMoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_PostsPreviewProps>();
    final userId = props.userId;
    return TextButton(
      child: const Text('Show more'),
      onPressed: () {
        Navigator.of(context).pushNamed(
          PostsScreen.routeName,
          arguments: PostsScreenArgs(userId: userId),
        );
      },
    );
  }
}

class _PostPreview extends StatelessWidget {
  final PostModel post;

  const _PostPreview({
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
