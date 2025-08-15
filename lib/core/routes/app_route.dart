import 'package:daneshyar/features/home/view/widgets/category/all_categories_screen.dart';
import 'package:daneshyar/features/onboarding/view/onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../../features/authentication/auth/complete_profile/view/complete_profile_screen.dart';
import '../../features/authentication/auth/login/view/login_screen.dart';
import '../../features/authentication/auth/otp/view/otp_screen.dart';
import '../../initial_decider_screen.dart';
import 'main_bottom_nav.dart';

// class AppRoute {
//   static const String initialDeciderScreen = "/";
//   static const String home = "/home";
//   static const String login = "/login";
//   static const String otp = "/otp";
//   static const String bookingForm = "/bookingForm";
//   static const String favorites = "/favorites";
//   static const String profile = "/profile";
//   static const String onboarding = "/onboarding";
//
//   static final Map<String, WidgetBuilder> routes = {
//     initialDeciderScreen: (ctx) => const InitialDeciderScreen(),
//     login: (ctx) => const LoginScreen(),
//     onboarding : (ctx) => const OnboardingScreen(),
//     home: (ctx) => const HomeScreen(),
//     otp: (ctx) => const OtpScreen(),
//   };
// }

class AppRoute {
  static const String initialDeciderScreen = "/";
  static const String home = "/home";
  static const String login = "/login";
  static const String otp = "/otp";
  static const String onboarding = "/onboarding";
  static const String completeProfile = "/completeProfile";
  static const String mainScreen = "/mainScreen";
  static const String allCategories = "/allCategories";

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(body: Center(child: Text('Error: $message'))),
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const InitialDeciderScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case '/completeProfile':
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final phoneNumber = args['phoneNumber'] ?? '';
        // final phoneNumber = settings.arguments as String?;
        if (phoneNumber == null) {
          return _errorRoute("Phone number not provided.");
        }
        return MaterialPageRoute(
          builder: (_) => CompleteProfileScreen(phoneNumber: phoneNumber),
        );

      case '/otp':
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(phoneNumber: phoneNumber),
        );
      case '/mainScreen':
        return MaterialPageRoute(builder: (_) => const MainBottomNav());
      // case '/login':
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/allCategories':
        return MaterialPageRoute(builder: (_) => const AllCategoriesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
