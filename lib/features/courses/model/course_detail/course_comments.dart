class CourseComments {
  final String userId;
  final String parentId;
  final String courseId;
  final String userName;
  final String userAvatar;
  final String commentText;
  final String commentDate;
  final int rating;

  CourseComments({
    required this.userId,
    required this.parentId,
    required this.courseId,
    required this.userName,
    required this.userAvatar,
    required this.commentText,
    required this.commentDate,
    required this.rating,
  });

  factory CourseComments.fromJson(Map<String, dynamic> json) {
    return CourseComments(
      userId: json['user_id'],
      parentId: json['parent_id'],
      courseId: json['course_id'],
      userName: json['user_name'],
      userAvatar: json['user_avatar'],
      commentText: json['comment_text'],
      commentDate: json['comment_date'],
      rating: json['rating'],
    );
  }

  factory CourseComments.initial() {
    return CourseComments(
      userId: '',
      parentId: '',
      courseId: '',
      userName: '',
      userAvatar: '',
      commentText: '',
      commentDate: '',
      rating: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'parent_id': parentId,
      'course_id': courseId,
      'user_name': userName,
      'user_avatar': userAvatar,
      'comment_text': commentText,
      'comment_date': commentDate,
      'rating': rating,
    };
  }

  CourseComments copyWith({
    String? userId,
    String? parentId,
    String? courseId,
    String? userName,
    String? userAvatar,
    String? commentText,
    String? commentDate,
    int? rating,
  }) {
    return CourseComments(
      userId: userId ?? this.userId,
      parentId: parentId ?? this.parentId,
      courseId: courseId ?? this.courseId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      commentText: commentText ?? this.commentText,
      commentDate: commentDate ?? this.commentDate,
      rating: rating ?? this.rating,
    );
  }
}
