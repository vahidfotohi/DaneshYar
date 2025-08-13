import 'package:daneshyar/features/home/model/course_model.dart';
import 'package:flutter/material.dart';

class PopularCoursesCard extends StatelessWidget {
  final CourseModel course;
  const PopularCoursesCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return SizedBox(
      width: 280,

      child: Card(
        color: Theme.of(context).colorScheme.surfaceBright,
        elevation: 3,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    course.imagePath,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(child: Text("data"),top: 8,right: 8,)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text("title", style: theme.textTheme.titleLarge),
                  Row(
                    children: [
                      Container(decoration: const BoxDecoration(color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
