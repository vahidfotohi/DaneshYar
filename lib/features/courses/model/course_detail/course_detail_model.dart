import 'package:daneshyar/features/courses/model/base/course_info.dart';
import 'course_comments.dart';
import 'course_detail_explanations.dart';
import 'course_season_info.dart';

class CourseDetailModel {
  final CourseInfo courseInfo;
  final CourseDetailExplanations details;
  final List<CourseSeasonInfo> seasonInfo;
  final List<CourseComments> comments;
  final int sessionsCount;
  final bool certification;
  final int commentsCount;

  CourseDetailModel({
    required this.comments,
    required this.courseInfo,
    required this.details,
    required this.seasonInfo,
    required this.sessionsCount,
    required this.certification,
    required this.commentsCount,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) {
    var seasonList = json['season_info'] as List;
    List<CourseSeasonInfo> seasonInfoList = seasonList.map((i) => CourseSeasonInfo.fromJson(i)).toList();

    var commentsList = json['comments'] as List;
    List<CourseComments> comments = commentsList.map((i) => CourseComments.fromJson(i)).toList();

    return CourseDetailModel(
      courseInfo: CourseInfo.fromJson(json['course_info']),
      details: CourseDetailExplanations.fromJson(json['details']),
      seasonInfo: seasonInfoList,
      comments: comments,
      sessionsCount: json['sessions_count'],
      certification: json['certification'],
      commentsCount: json['comments_count'],
    );
  }

  factory CourseDetailModel.initial() {
    return CourseDetailModel(
      courseInfo: CourseInfo.initial(),
      details: CourseDetailExplanations.initial(),
      seasonInfo: [],
      comments: [],
      sessionsCount: 0,
      certification: false,
      commentsCount: 0,
    );
  }

  CourseDetailModel copyWith({
    CourseInfo? courseInfo,
    CourseDetailExplanations? details,
    List<CourseSeasonInfo>? seasonInfo,
    List<CourseComments>? comments,
    int? sessionsCount,
    bool? certification,
    int? commentsCount,
  }) {
    return CourseDetailModel(
      courseInfo: courseInfo ?? this.courseInfo,
      details: details ?? this.details,
      seasonInfo: seasonInfo ?? this.seasonInfo,
      comments: comments ?? this.comments,
      sessionsCount: sessionsCount ?? this.sessionsCount,
      certification: certification ?? this.certification,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }

  Map<String , dynamic> toJson(){
    return {
      'course_info': courseInfo.toJson(),
      'details': details.toJson(),
      'season_info': seasonInfo.map((e) => e.toJson()).toList(),
      'comments': comments.map((e) => e.toJson()).toList(),
      'sessions_count': sessionsCount,
      'certification': certification,
      'comments_count': commentsCount,
    };
  }
}
