class CourseDetailExplanations {
  final String description;
  final String mentorBio;
  final String mentorName;
  final int numberOfStudents;
  final String levelCourse;
  final String lastUpdateCourse;
  final String totalCourseTime;
  final int price;
  final int? discountPrice;
  final int? discountPercentage;

  CourseDetailExplanations({
    required this.description,
    required this.mentorBio,
    required this.mentorName,
    required this.numberOfStudents,
    required this.levelCourse,
    required this.lastUpdateCourse,
    required this.totalCourseTime,
    required this.price,
    this.discountPrice,
    this.discountPercentage,
  });

  factory CourseDetailExplanations.fromJson(Map<String, dynamic> json) {
    return CourseDetailExplanations(
      description: json['description'],
      mentorBio: json['mentor_bio'],
      mentorName: json['mentor_name'],
      numberOfStudents: json['number_of_students'],
      levelCourse: json['level_course'],
      lastUpdateCourse: json['last_update_course'],
      totalCourseTime: json['total_course_time'],
      price: json['price'],
      discountPrice: json['discount_price'],
      discountPercentage: json['discount_percentage'],
    );
  }

  factory CourseDetailExplanations.initial() {
    return CourseDetailExplanations(
      description: '',
      mentorBio: '',
      mentorName: '',
      numberOfStudents: 0,
      levelCourse: '',
      lastUpdateCourse: '',
      totalCourseTime: '',
      price: 0,
      discountPrice: null,
      discountPercentage: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'mentor_bio': mentorBio,
      'mentor_name': mentorName,
      'number_of_students': numberOfStudents,
      'level_course': levelCourse,
      'last_update_course': lastUpdateCourse,
      'total_course_time': totalCourseTime,
      'price': price,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
    };
  }

  CourseDetailExplanations copyWith({
    String? description,
    String? mentorBio,
    String? mentorName,
    int? numberOfStudents,
    String? levelCourse,
    String? lastUpdateCourse,
    String? totalCourseTime,
    int? price,
    int? discountPrice,
    int? discountPercentage,
  }) {
    return CourseDetailExplanations(
      description: description ?? this.description,
      mentorBio: mentorBio ?? this.mentorBio,
      mentorName: mentorName ?? this.mentorName,
      numberOfStudents: numberOfStudents ?? this.numberOfStudents,
      levelCourse: levelCourse ?? this.levelCourse,
      lastUpdateCourse: lastUpdateCourse ?? this.lastUpdateCourse,
      totalCourseTime: totalCourseTime ?? this.totalCourseTime,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }
}
