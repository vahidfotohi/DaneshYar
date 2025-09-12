import 'package:daneshyar/core/constants/constants.dart';
import 'package:daneshyar/core/constants/strings.dart';
import 'package:daneshyar/features/mentor/provider/mentor_provider.dart';
import 'package:daneshyar/features/mentor/view/widgets/popular_mentor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularMentors extends ConsumerWidget {
  const PopularMentors({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    // final colorScheme = theme.colorScheme;
    final mentorState = ref.watch(mentorProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppColors.listCategory),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  AppStrings.mentorShowAll,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.lightTextSecondary,
                  ),
                ),
              ),
              Text(
                AppStrings.mentorTitle,
                style: textTheme.headlineSmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 130,
            child: Builder(
              builder: (context) {
                final mentors = mentorState.mentors;
                return ListView.separated(
                  reverse: true,
                  scrollDirection: Axis.horizontal,

                  itemCount: mentors.length,

                  separatorBuilder: (BuildContext _, int _) =>
                      const SizedBox(width: 12),
                  itemBuilder: (BuildContext context, int index) {
                    final mentor = mentors[index];
                    return PopularMentorCard(mentor: mentor);
                  },

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
