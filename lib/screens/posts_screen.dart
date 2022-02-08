import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/post_model.dart';
import 'package:flutter_test_work/widgets/previews/post_preview.dart';
import 'package:flutter_test_work/widgets/utils/preloader.dart';
import 'package:flutter_test_work/widgets/utils/props_widget.dart';

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

    return FutureBuilder<List<PostModel>>(
      future: ApiJsonPlaceholder.getPosts(routeArgs.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _ScreenProps(
            posts: snapshot.data!,
          );
        } else {
          return const Preloader();
        }
      },
    );
  }
}

class _ScreenProps extends PropsWidget {
  final List<PostModel> posts;

  _ScreenProps({
    required this.posts,
  }) : super(child: _Screen());
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: _PostsList(),
      ),
    );
  }
}

class _PostsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final posts = props.posts;
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostPreview(post: post);
      },
    );
  }
}
