
import '../base/course_info.dart';

class MyCourseModel {
  final CourseInfo courseInfo;
  final double progress;
  final String categoryName;
  final String unfinishedSessionName;
  final int completedSessions;
  final int totalSessions;

  MyCourseModel({
    required this.courseInfo,
    required this.progress,
    required this.categoryName,
    required this.unfinishedSessionName,
    required this.completedSessions,
    required this.totalSessions,
  });

  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      courseInfo: CourseInfo.fromJson(json['course_info']),
      progress: json['progress'].toDouble(),
      categoryName: json['category_name'],
      unfinishedSessionName: json['unfinished_session_name'],
      completedSessions: json['completed_sessions'],
      totalSessions: json['total_sessions'],
    );
  }

  factory MyCourseModel.initial() {
    return MyCourseModel(
      courseInfo: CourseInfo.initial(),
      progress: 0.0,
      categoryName: '',
      unfinishedSessionName: '',
      completedSessions: 0,
      totalSessions: 0,
    );
  }

  MyCourseModel copyWith({
    CourseInfo? courseInfo,
    double? progress,
    String? categoryName,
    String? unfinishedSessionName,
    int? completedSessions,
    int? totalSessions,
  }) {
    return MyCourseModel(
      courseInfo: courseInfo ?? this.courseInfo,
      progress: progress ?? this.progress,
      categoryName: categoryName ?? this.categoryName,
      unfinishedSessionName: unfinishedSessionName ?? this.unfinishedSessionName,
      completedSessions: completedSessions ?? this.completedSessions,
      totalSessions: totalSessions ?? this.totalSessions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_info': courseInfo.toJson(),
      'progress': progress,
      'category_name': categoryName,
      'unfinished_session_name': unfinishedSessionName,
      'completed_sessions': completedSessions,
      'total_sessions': totalSessions,
    };
  }
}
