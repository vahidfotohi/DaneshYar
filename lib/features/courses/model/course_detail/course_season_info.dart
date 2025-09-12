
import '../../../my_courses/model/my_course_model.dart';

class CourseSeasonInfo {
  final String seasonTitle;
  final String seasonDuration;
  final List<CourseSession> courseSessions;

  CourseSeasonInfo({
    required this.seasonTitle,
    required this.seasonDuration,
    required this.courseSessions,
  });

  factory CourseSeasonInfo.fromJson(Map<String, dynamic> json) {
    var list = json['course_sessions'] as List;
    List<CourseSession> courseSessionList = list.map((i) => CourseSession.fromJson(i)).toList();

    return CourseSeasonInfo(
      seasonTitle: json['season_title'],
      seasonDuration: json['season_duration'],
      courseSessions: courseSessionList,
    );
  }

  factory CourseSeasonInfo.initial() {
    return CourseSeasonInfo(
      seasonTitle: '',
      seasonDuration: '',
      courseSessions: [],
    );
  }

  CourseSeasonInfo copyWith({
    String? seasonTitle,
    String? seasonDuration,
    List<CourseSession>? courseSessions,
  }) {
    return CourseSeasonInfo(
      seasonTitle: seasonTitle ?? this.seasonTitle,
      seasonDuration: seasonDuration ?? this.seasonDuration,
      courseSessions: courseSessions ?? this.courseSessions,
    );
  }

  Map<String , dynamic> toJson(){
    return {
      'season_title': seasonTitle,
      'season_duration': seasonDuration,
      'course_sessions': courseSessions.map((e) => e.toJson()).toList(),
    };
  }
}
