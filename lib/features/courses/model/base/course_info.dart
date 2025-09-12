class CourseInfo {
  final int id;
  final String title;
  final String cover;
  final String mentorName;
  final bool isMarked;

  CourseInfo({
    required this.id,
    required this.title,
    required this.cover,
    required this.mentorName,
    required this.isMarked,
  });

  factory CourseInfo.fromJson(Map<String, dynamic> json) {
    return CourseInfo(
      id: json['id'],
      title: json['title'],
      cover: json['cover'],
      mentorName: json['mentor_name'],
      isMarked: json['is_marked'],
    );
  }

  factory CourseInfo.initial() {
    return CourseInfo(
      id: 0,
      title: '',
      cover: '',
      mentorName: '',
      isMarked: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'cover': cover,
      'mentor_name': mentorName,
      'is_marked': isMarked,
    };
  }

  CourseInfo copyWith({
    int? id,
    String? title,
    String? cover,
    String? mentorName,
    bool? isMarked,
  }) {
    return CourseInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      mentorName: mentorName ?? this.mentorName,
      isMarked: isMarked ?? this.isMarked,
    );
  }
}
