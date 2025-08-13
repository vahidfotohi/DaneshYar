import 'dart:math';

import 'package:daneshyar/features/home/model/course_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseRepository {
  final _random = Random();

  List<CourseModel> courses(int count) {
    ///Todo Call Api
    // await Future.delayed(Duration(milliseconds: 500));
    return List.generate(count, (index) {
      final imageId = _random.nextInt(10);
      return CourseModel(
        id: index.toString(),
        imagePath: "https://picsum.photos/$imageId/237/200/300",
        star: (_random.nextDouble() * 5).toString(),
        // Generate a random star rating between 0 and 5
        isMarked: _random.nextBool(),
        title: 'دوره شماره $index',
        suggested: Suggested.values[_random.nextInt(Suggested.values.length)],
        mentorName: 'مدرس شماره $index',
        price: _random.nextInt(1000000).toString(),
      );
    });
  }

  Future<List<CourseModel>> fetchCourses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return courses(10);
  }

  final coursesRepositoryProvider = Provider((ref) => CourseRepository());
}
