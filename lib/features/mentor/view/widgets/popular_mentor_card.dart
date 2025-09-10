import 'package:daneshyar/features/mentor/model/mentor_model.dart';
import 'package:flutter/material.dart';

class PopularMentorCard extends StatelessWidget {
  final MentorModel mentor;

  const PopularMentorCard({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(AppRoute.mentorDetails);
          },
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.onSurfaceVariant),
            ),
            child: Container(
              height: 64,
              width: 64,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsetsGeometry.all(4),
                child: Image.network(
                  mentor.avatar,
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress == null
                        ? child
                        : const Center(child: null);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8,),
        Text(mentor.name,style: textTheme.bodyLarge,)
      ],
    );
  }
}
