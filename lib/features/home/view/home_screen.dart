import 'package:daneshyar/features/home/view/widgets/appbar/home_appbar.dart';
import 'package:daneshyar/features/home/view/widgets/category/category_section.dart';
import 'package:daneshyar/features/home/view/widgets/popularCourses/popular_courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = Theme.of(context);
    // final user = ref.watch(userProvider).user;
    // final appbarState = ref.watch(appbarViewmodelProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Positioned(
                bottom: -10,
                left: -10,
                child: Image.asset(
                  "assets/images/home/Pattern1.png",
                  color: Colors.black,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -20,
                right: -50,
                child: Image.asset(
                  "assets/images/home/Pattern2.png",
                  color: Colors.black,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const HomeAppBar(),
              // const CategorySection()
            ],
          ),
          const CategorySection(),
          const SizedBox(height: 0),
          const PopularCourses()
        ],
      ),
    );
  }
}
