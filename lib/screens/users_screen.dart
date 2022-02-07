import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/user_model.dart';
import 'package:flutter_test_work/screens/user_screen.dart';
import 'package:flutter_test_work/widgets/preloader.dart';
import 'package:flutter_test_work/widgets/props_widget.dart';
import 'package:flutter_test_work/widgets/user_preview.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = 'users';

  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: ApiJsonPlaceholder.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _ScreenProps(
            users: snapshot.data!,
          );
        } else {
          return const Preloader();
        }
      },
    );
  }
}

class _ScreenProps extends PropsWidget {
  final List<UserModel> users;

  _ScreenProps({
    required this.users,
  }) : super(child: _Screen());
}

class _Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: _UsersList(),
      ),
    );
  }
}

class _UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final props = context.props<_ScreenProps>();
    final users = props.users;
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserPreview(user: user);
      },
    );
  }
}
