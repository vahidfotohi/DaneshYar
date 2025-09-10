import 'package:daneshyar/core/theme/app_theme.dart';
import 'package:daneshyar/core/theme/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routes/app_route.dart';
import 'features/authentication/user/provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  final container = ProviderContainer();
  await container.read(userProvider.notifier).loadUserFromPrefs();
  await container.read(themeNotifierProvider.notifier).loadTheme();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "daneshYar",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      onGenerateRoute: AppRoute.generateRoute,
      initialRoute: AppRoute.initialDeciderScreen,
    );
  }
}
