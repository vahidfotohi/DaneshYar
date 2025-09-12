class CourseSession {
  final String sessionId;
  final String sessionTitle;
  final int sessionDuration;
  final bool isFree;

  CourseSession({
    required this.sessionId,
    required this.sessionTitle,
    required this.sessionDuration ,
    required this.isFree,
  });

  factory CourseSession.fromJson(Map<String, dynamic> json) {
    return CourseSession(
      sessionId: json['session_id'],
      sessionTitle: json['session_title'],
      sessionDuration : json['session_duration'],
      isFree: json['is_free'],
    );
  }

  factory CourseSession.initial() {
    return CourseSession(
      sessionId: '',
      sessionTitle: '',
      sessionDuration : 0,
      isFree: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'session_title': sessionTitle,
      'session_duration': sessionDuration,
      'is_free': isFree,
    };
  }

  CourseSession copyWith({
    String? sessionId,
    String? sessionTitle,
    int? sessionDuration,
    bool? isFree,
  }) {
    return CourseSession(
      sessionId: sessionId ?? this.sessionId,
      sessionTitle: sessionTitle ?? this.sessionTitle,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      isFree: isFree ?? this.isFree,
    );
  }
}
