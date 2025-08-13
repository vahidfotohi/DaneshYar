import 'package:daneshyar/features/home/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class AllCategoriesScreen extends ConsumerWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("دسته بندی ها", style: theme.textTheme.headlineMedium),
        // automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.surfaceBright,
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 140,
              crossAxisCount: 4,
              childAspectRatio: 0.75,
              mainAxisSpacing: 5,
              crossAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              final item = categories[index];
              return SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: theme.colorScheme.primaryFixedDim,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryFixed.withValues(
                            alpha: 0.09,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(item.imageUrl),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.title,
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
