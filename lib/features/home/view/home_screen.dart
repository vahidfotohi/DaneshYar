import 'package:daneshyar/features/home/view/widgets/home_page_shimmer_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../authentication/appbar/view/home_appbar.dart';
import '../../category/view/category_section.dart';
import '../../courses/view/popular_courses.dart';
import '../provider/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = Theme.of(context);
    // final user = ref.watch(userProvider).user;
    // final appbarState = ref.watch(appbarViewmodelProvider);
    final homeState = ref.watch(homeProvider);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(400),
        child: HomeAppBar(),
      ),
      body: Builder(
        builder: (context) {
          if (homeState.isLoading) {
            return const HomePageShimmerSkeleton();
          } else if (homeState.hasError) {
            return Center(
              child: Text(
                'خطا در بارگذاری صفحه اصلی: ${homeState.errorMessage}',
              ),
            );
          }
          return const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CategorySection(),
                SizedBox(height: 0),
                PopularCourses(),
                SizedBox(height: 24),
                // const TopMentorsSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}
