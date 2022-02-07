import 'package:flutter/material.dart';
import 'package:flutter_test_work/models/comment_model.dart';
import 'package:flutter_test_work/widgets/email_link.dart';
import 'package:flutter_test_work/widgets/filed_divider.dart';
import 'package:flutter_test_work/widgets/filed_title.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;

  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment.body),
            const FieldDivider(),
            Text(comment.name),
            Row(
              children: [
                FieldTitle(title: 'Email: '),
                EmailLink(
                  email: comment.email,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
