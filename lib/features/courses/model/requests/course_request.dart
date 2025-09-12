class CourseRequest {
  final int categoryId;

  CourseRequest({required this.categoryId});

  Map<String, dynamic> toJson() {
    return {'categoryId': categoryId};
  }

  factory CourseRequest.fromJson(Map<String, dynamic> json) {
    return CourseRequest(categoryId: json['categoryId']);
  }
}
