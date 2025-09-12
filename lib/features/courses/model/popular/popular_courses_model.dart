
import '../base/course_info.dart';

enum Suggested { none, suggested }

class PopularCoursesModel {
  final CourseInfo courseInfo;
  final String? star;
  final Suggested suggested;

  final String price;
  final String? offerPrice;

  PopularCoursesModel({
    required this.courseInfo,
    required this.suggested,
    required this.price,
    this.star,
    this.offerPrice,
  });

  factory PopularCoursesModel.fromJson(Map<String, dynamic> json) {
    return PopularCoursesModel(
      courseInfo: CourseInfo.fromJson(json['course_info']),
      star: json['star'],
      suggested: json['suggested'] == 'suggested'
          ? Suggested.suggested
          : Suggested.none,
      price: json['price'],
      offerPrice: json['offer_price'],
    );
  }

  factory PopularCoursesModel.initial() {
    return PopularCoursesModel(
      courseInfo: CourseInfo.initial(),
      suggested: Suggested.none,
      price: '',
      star: null,
      offerPrice: null,
    );
  }

  PopularCoursesModel copyWith({
    CourseInfo? courseInfo,
    String? star,
    Suggested? suggested,
    String? price,
    String? offerPrice,
  }) {
    return PopularCoursesModel(
      courseInfo: courseInfo ?? this.courseInfo,
      star: star ?? this.star,
      suggested: suggested ?? this.suggested,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_info': courseInfo.toJson(),
      'star': star,
      'suggested': suggested == Suggested.suggested ? 'suggested' : 'none',
      'price': price,
      'offer_price': offerPrice,
    };
  }
}
