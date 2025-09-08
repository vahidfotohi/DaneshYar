import 'package:daneshyar/features/home/courses/view/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/course_provider.dart';

class PopularCourses extends ConsumerWidget {
  const PopularCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final courseState = ref.watch(courseProvider);
    final popularCourses = ref
        .read(courseProvider.notifier)
        .popularCourses;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0 , horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // برو به صفحه همه‌ی دوره‌ها
                },
                child: const Text('مشاهده همه'),
              ),
              Text(
                'محبوب‌ترین دوره‌ها',
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              // const SizedBox(wi: 16),
              if (courseState.isLoading)
                const Center(child: CircularProgressIndicator()),
              if (courseState.hasError)
                Center(
                  child: Text(
                    'خطا در بارگذاری دوره‌ها: ${courseState.errorMessage}',
                  ),
                ),

            ],
          ),
        ),

        if (!courseState.isLoading && !courseState.hasError)
          SizedBox(
            height: 310,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: popularCourses.length,
              separatorBuilder: (context, index) =>
              const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final course = popularCourses[index];
                return PopularCoursesCard(course: course);
              },
            ),
          ),
      ],
    );
  }
}
