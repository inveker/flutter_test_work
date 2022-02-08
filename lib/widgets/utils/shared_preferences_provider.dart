import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/widgets/utils/preloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends StatelessWidget {
  final Widget child;

  const SharedPreferencesProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RepositoryProvider(
            create: (context) => snapshot.data!,
            lazy: false,
            child: child,
          );
        } else {
          return const Preloader();
        }
      },
    );
  }
}
