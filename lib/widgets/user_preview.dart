import 'package:flutter/material.dart';
import 'package:flutter_test_work/models/user_model.dart';
import 'package:flutter_test_work/screens/user_screen.dart';

class UserPreview extends StatelessWidget {
  final UserModel user;

  const UserPreview({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.username),
        subtitle: Text(user.name),
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          Navigator.of(context).pushNamed(
            UserScreen.routeName,
            arguments: UserScreenArgs(
              userId: user.id,
            ),
          );
        },
      ),
    );
  }
}
