import 'package:daneshyar/core/constants/constants.dart';
import 'package:daneshyar/features/home/courses/model/course_model.dart';
import 'package:flutter/material.dart';

class PopularCoursesCard extends StatelessWidget {
  final CourseModel course;

  const PopularCoursesCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return SizedBox(
      width: 310,
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
                    course.cover,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star_rounded, color: AppColors.starColor),
                        Text("4.5"),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: course.isMarked
                        ? Icon(
                            Icons.bookmark_rounded,
                            color: theme.colorScheme.primaryFixed,
                          )
                        : const Icon(
                            Icons.bookmark_outline_rounded,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    course.title,
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign:  TextAlign.right,
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          course.suggested.name,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        course.mentorName,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(Icons.verified_rounded, color: Colors.grey.shade500),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Divider(
                    color: Colors.grey.shade400,
                    thickness: 1,
                    indent: 3,
                    endIndent: 3,
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: course.offerPrice != null
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.end,

                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: course.offerPrice != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.discount_rounded,
                                    color: theme.colorScheme.error,
                                  ),

                                  Text(
                                    course.offerPrice.toString(),
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                          color: theme.colorScheme.error,
                                        ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                      Text(
                      course.price,
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.primaryFixed,
                        ),
                        textAlign: TextAlign.right,
                        textDirection:  TextDirection.rtl,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24,)
          ],
        ),
      ),
    );
  }
}
