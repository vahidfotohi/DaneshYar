import 'package:daneshyar/core/routes/app_route.dart';
import 'package:daneshyar/features/home/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              TextButton(

                onPressed: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed(AppRoute.allCategories);
                },

                child: const Text(
                  "مشاهده همه",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              Text(
                "دسته بندی ها",
                style: theme.textTheme.headlineSmall!.copyWith(fontSize: 18,fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 130,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            reverse: true,
            itemCount: categories.length,
            separatorBuilder: (BuildContext _, int __) =>
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
                          color: theme.colorScheme.primaryFixedDim,
                        ),
                      ),
                      child: Container(
                        height: 64,
                        width: 64,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primaryFixed.withValues(
                            alpha: 0.1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            item.imageUrl,

                            height: 54,
                            width: 54,
                            colorFilter: ColorFilter.mode(
                              theme.colorScheme.primaryFixed,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(item.title, style: theme.textTheme.bodyLarge),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
