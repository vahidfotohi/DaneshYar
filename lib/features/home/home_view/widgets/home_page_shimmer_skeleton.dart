// فایل پیشنهادی: features/home/widgets/home_shimmer_skeleton.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePageShimmerSkeleton extends StatelessWidget {
  const HomePageShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(), // جلوگیری از اسکرول در حالت لودینگ
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ۱. شبیه‌سازی بخش دسته‌بندی‌ها (Categories)
            _buildShimmerHeader(),
            const SizedBox(height: 16),
            _buildHorizontalList(itemBuilder: _buildCategoryShimmerItem),
            const SizedBox(height: 8),

            // ۲. شبیه‌سازی بخش دوره‌های محبوب (Popular Courses)
            _buildShimmerHeader(),
            const SizedBox(height: 16),
            _buildHorizontalList(itemBuilder: _buildCourseCardShimmerItem),
            const SizedBox(height: 24),

            // ۳. شبیه‌سازی بخش مدرسین برتر (Top Mentors) - فرض می‌کنیم شبیه دسته‌بندی است
            _buildShimmerHeader(),
            const SizedBox(height: 16),
            _buildHorizontalList(itemBuilder: _buildCategoryShimmerItem),
          ],
        ),
      ),
    );
  }

  // هدر بخش (متن عنوان)
  Widget _buildShimmerHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Container(
          width: 120,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  // آیتم شیمر برای دسته‌بندی یا مدرس (دایره و متن کوتاه)
  Widget _buildCategoryShimmerItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 10,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // آیتم شیمر برای کارت دوره (مستطیل بزرگ)
  Widget _buildCourseCardShimmerItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 320, // عرض کارت دوره
        height: 280, // ارتفاع کارت دوره
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // سازنده لیست افقی شیمر
  Widget _buildHorizontalList({
    required Widget Function(BuildContext context) itemBuilder,
    double height = 180, // ارتفاع تقریبی لیست افقی
  }) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4, // تعداد آیتم‌های شیمر نمونه
        itemBuilder: (context, index) => itemBuilder(context),
      ),
    );
  }
}