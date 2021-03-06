import 'package:flutter/material.dart';
import 'package:flutter_test_work/router/app_router.dart';
import 'package:flutter_test_work/widgets/utils/shared_preferences_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SharedPreferencesProvider(
      child: MaterialApp(
        initialRoute: AppRouter.initialRoute,
        onGenerateRoute: AppRouter.onGenerateRoute,
        onUnknownRoute: AppRouter.onUnknownRoute,
      ),
    );
  }
}
