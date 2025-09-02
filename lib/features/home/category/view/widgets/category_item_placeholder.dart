import 'package:flutter/material.dart';

/// ویجت Placeholder برای یک آیتم دسته‌بندی در حالت لودینگ
class CategoryItemPlaceholder extends StatelessWidget {
  const CategoryItemPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // دایره خاکستری به جای عکس
        Container(
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            color: Colors.white, // رنگ پس‌زمینه ویجت زیر شیمر
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 12),
        // مستطیل خاکستری به جای متن
        Container(
          height: 10,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}