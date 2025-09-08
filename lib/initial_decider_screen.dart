import 'package:daneshyar/features/authentication/user/provider/user_provider.dart';

import 'core/network/network_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/app_route.dart';

final initialRouteProvider = FutureProvider<String>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);

  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('onboarding_seen') ?? false;

  if (!hasSeenOnboarding) {
    await prefs.setBool('onboarding_seen', true);
    return AppRoute.onboarding;
  }

  final isLoggedIn = await authRepository.isAuthenticated();
  if (!isLoggedIn) {
    return AppRoute.login;
  }

  final isProfileCompleted = await authRepository.isProfileCompleted();
  if (!isProfileCompleted) {
    return AppRoute.completeProfile;
  }

  return AppRoute.mainScreen;
});

class InitialDeciderScreen extends ConsumerWidget {
  const InitialDeciderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialRouteAsync = ref.watch(initialRouteProvider);

    return initialRouteAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) =>
          Scaffold(body: Center(child: Text('خطا در راه‌اندازی برنامه: $err'))),
      data: (routeName) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ModalRoute.of(context)?.isCurrent ?? false) {
            if(routeName == AppRoute.completeProfile){
              final user = ref.read(userProvider).user;
              if(user !=null){
                Navigator.pushReplacementNamed(context, routeName , arguments: {'phoneNumber' : user.phone});
              }else{
                Navigator.pushReplacementNamed(context, AppRoute.login);
              }
            }else{
              Navigator.pushReplacementNamed(context, routeName);
            }
           
          }
        });

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
