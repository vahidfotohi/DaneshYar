import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'category_item_placeholder.dart';

class ShimmerLoadingGrid extends StatelessWidget {
  const ShimmerLoadingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 140,
          crossAxisCount: 4,
          childAspectRatio: 0.75,
          mainAxisSpacing: 5,
          crossAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          return const CategoryItemPlaceholder();
        },
      ),
    );
  }
}