import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/bloc/comment_form/comment_form_bloc.dart';
import 'package:flutter_test_work/models/comment_model.dart';
import 'package:flutter_test_work/models/post_model.dart';
import 'package:flutter_test_work/widgets/forms/comment_form.dart';
import 'package:flutter_test_work/widgets/full_cards/comment_card.dart';
import 'package:flutter_test_work/widgets/data_fields/field_divider.dart';
import 'package:flutter_test_work/widgets/data_fields/field_title.dart';
import 'package:flutter_test_work/widgets/full_cards/post_card.dart';
import 'package:flutter_test_work/widgets/utils/preloader.dart';
import 'package:flutter_test_work/widgets/utils/props_widget.dart';

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
      child: _Bloc(
        postId: routeArgs.postId,
        builder: (context) => FutureBuilder<PostModel>(
          future: ApiJsonPlaceholder.getPost(routeArgs.postId),
          builder: (context, snapshot) {
            print('NEW SNAPSHOT');
            if (snapshot.hasData) {
              return _ScreenProps(
                post: snapshot.data!,
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

class _Bloc extends StatelessWidget {
  final int postId;
  final Widget Function(BuildContext) builder;

  const _Bloc({
    Key? key,
    required this.builder,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentFormBloc(postId: postId),
      child: BlocBuilder<CommentFormBloc, CommentFormState>(
        buildWhen: (p, n) => p.status != n.status && n.status == CommentFormStateStatus.success,
        builder: (context, state) {
          return builder(context);
        },
      ),
    );
  }
}

class _ScreenProps extends PropsWidget {
  final PostModel post;

  _ScreenProps({
    required this.post,
  }) : super(child: _Screen());
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final post = props.post;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post: ${post.title}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostCard(
              post: post,
            ),
            const FieldDivider(),
            _CommentsField(),
            const FieldDivider(),
            CommentForm(
              postId: post.id,
              bloc: context.read<CommentFormBloc>(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentsField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final post = props.post;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldTitle(
            title: 'Comments',
          ),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<CommentModel>>(
            future: ApiJsonPlaceholder.getComments(post.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _CommentsList(
                  comments: snapshot.data!,
                );
              } else {
                return const Preloader(bgColor: Colors.transparent);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _CommentsList extends StatelessWidget {
  final List<CommentModel> comments;

  const _CommentsList({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var comment in comments)
          CommentCard(
            comment: comment,
          ),
      ],
    );
  }
}
