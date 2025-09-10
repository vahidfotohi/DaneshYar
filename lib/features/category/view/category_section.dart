import 'package:daneshyar/core/constants/constants.dart';
import 'package:daneshyar/core/constants/strings.dart';
import 'package:daneshyar/core/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/category_provider.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final categoryState = ref.watch(categoryProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed(AppRoute.allCategories);
                },
                child:  const Text(
                  AppStrings.categoryShowAll,
                  style: TextStyle(fontSize: 13, color:AppColors.lightTextSecondary),
                ),
              ),
              Text(
                AppStrings.categoryTitle,
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
                final categories = categoryState.categories;
                return ListView.separated(
                  // padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  reverse: true,

                  itemCount: categories.length,
                  separatorBuilder: (BuildContext _, int _) =>
                      const SizedBox(width: 12),
                  itemBuilder: (BuildContext context, int index) {

                    final item = categories[index];
                    return Column(
                      children: [
                        GestureDetector(

                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 84,
                            width: 84,
                            decoration: BoxDecoration(

                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.primaryFixedDim,
                              ),
                            ),
                            child: Container(
                              height: 64,
                              width: 64,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.primaryFixed.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(
                                  item.icon,
                                  height: 54,
                                  width: 54,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
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
                        const SizedBox(height: 8),
                        Text(item.title, style: textTheme.bodyLarge),
                      ],
                    );
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
