import 'package:daneshyar/features/home/view/widgets/popularCourses/popular_courses_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/course_provider.dart';

class PopularCourses extends ConsumerWidget {
  const PopularCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final courses = ref.watch(courseViewmodelProvider);
    final viewModel = ref.read(courseViewmodelProvider.notifier);
    final popularCourses = viewModel.getPopularCourses();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // برو به صفحه همه‌ی دوره‌ها
                },
                child: Text('مشاهده همه'),
              ),
              Text(
                'محبوب‌ترین دوره‌ها',
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8,),

              ListView.builder(
                itemCount: popularCourses.length,
                itemBuilder: (context, index) {
                  final course = popularCourses[index];
                  return PopularCoursesCard(
                    course: course,
                  );
                },
              )

            ],
          ),
          PopularCoursesCard(course: courses[0],)
        ],
      ),
    );
  }
}
