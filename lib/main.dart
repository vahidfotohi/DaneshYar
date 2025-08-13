import 'package:daneshyar/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routes/app_route.dart';
import 'features/authentication/user/provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(userProvider.notifier).loadUserFromPrefs();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "daneshYar",

      theme: AppTheme.lightTheme,
      // home:  const MyHomePage(),
      onGenerateRoute: AppRoute.generateRoute,
      initialRoute: AppRoute.initialDeciderScreen,
    );
  }
}
