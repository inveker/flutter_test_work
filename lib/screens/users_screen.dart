import 'package:flutter/material.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/models/user_model.dart';
import 'package:flutter_test_work/screens/user_screen.dart';
import 'package:flutter_test_work/widgets/preloader.dart';

class UsersScreen extends StatefulWidget {
  static const routeName = 'users';

  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<UserModel>>(
          future: ApiJsonPlaceholder.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _UsersList(
                users: snapshot.data!,
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

class _UsersList extends StatelessWidget {
  final List<UserModel> users;

  const _UsersList({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
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
      },
    );
  }
}
