import '../../mentor/model/mentor_model.dart';

class MyCourseModel {
  final int id;
  final String flagPublished;
  final String title;
  final String cover;
  final String tizer;
  final String mentorId;
  final String categoryCoursesId;
  final bool flagCertification;
  final String description;
  final String level;
  final String price;
  final dynamic discountPrice;
  final dynamic discountUntil;
  final int percent;
  final int totalCount;
  final int viewCount;
  final Pivot pivot;
  final MentorModel mentor;
  final List<CourseSession> courseSession;
  final List<dynamic> courseCustomerSession;

  MyCourseModel({
    required this.id,
    required this.flagPublished,
    required this.title,
    required this.cover,
    required this.tizer,
    required this.mentorId,
    required this.categoryCoursesId,
    required this.flagCertification,
    required this.description,
    required this.level,
    required this.price,
    required this.discountPrice,
    required this.discountUntil,
    required this.percent,
    required this.totalCount,
    required this.viewCount,
    required this.pivot,
    required this.mentor,
    required this.courseSession,
    required this.courseCustomerSession,
  });

  factory MyCourseModel.initial() => MyCourseModel(
    id: 0,
    flagPublished: "",
    title: "",
    cover: "",
    tizer: "",
    mentorId: "",
    categoryCoursesId: "",
    flagCertification: false,
    description: "",
    level: "",
    price: "",
    discountPrice: null,
    discountUntil: null,
    percent: 0,
    totalCount: 0,
    viewCount: 0,
    pivot: Pivot(customerId: "", courseId: ""),
    mentor: MentorModel.initial(),
    courseSession: [],
    courseCustomerSession: [],
  );

  MyCourseModel copyWith({
    int? id,
    String? flagPublished,
    String? title,
    String? cover,
    String? tizer,
    String? mentorId,
    String? categoryCoursesId,
    bool? flagCertification,
    String? description,
    String? level,
    String? price,
    dynamic discountPrice,
    dynamic discountUntil,
    int? percent,
    int? totalCount,
    int? viewCount,
    Pivot? pivot,
    MentorModel? mentor,
    List<CourseSession>? courseSession,
    List<dynamic>? courseCustomerSession,
  }) {
    return MyCourseModel(
      id: id ?? this.id,
      flagPublished: flagPublished ?? this.flagPublished,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      tizer: tizer ?? this.tizer,
      mentorId: mentorId ?? this.mentorId,
      categoryCoursesId: categoryCoursesId ?? this.categoryCoursesId,
      flagCertification: flagCertification ?? this.flagCertification,
      description: description ?? this.description,
      level: level ?? this.level,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      discountUntil: discountUntil ?? this.discountUntil,
      percent: percent ?? this.percent,
      totalCount: totalCount ?? this.totalCount,
      viewCount: viewCount ?? this.viewCount,
      pivot: pivot ?? this.pivot,
      mentor: mentor ?? this.mentor,
      courseSession: courseSession ?? this.courseSession,
      courseCustomerSession:
          courseCustomerSession ?? this.courseCustomerSession,
    );
  }

  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    var list = json['course_session'] as List;
    List<CourseSession> courseSessionList = list
        .map((i) => CourseSession.fromJson(i))
        .toList();

    return MyCourseModel(
      id: json['id'],
      flagPublished: json['flag_published'],
      title: json['title'],
      cover: json['cover'],
      tizer: json['tizer'],
      mentorId: json['mentor_id'],
      categoryCoursesId: json['category_courses_id'],
      flagCertification: json['flag_certification'],
      description: json['description'],
      level: json['level'],
      price: json['price'],
      discountPrice: json['discount_price'],
      discountUntil: json['discount_until'],
      percent: json['percent'],
      totalCount: json['total_count'],
      viewCount: json['view_count'],
      pivot: Pivot(
        customerId: json['pivot']['customer_id'],
        courseId: json['pivot']['course_id'],
      ),
      mentor: json['mentor'] != null ? MentorModel.fromJson(json['mentor'] as Map<String, dynamic>) : MentorModel.initial(),
      courseSession: courseSessionList,
      courseCustomerSession: json['course_customer_session'] ?? [],
    );
  }

  factory MyCourseModel.toJson(Map<String, dynamic> json) {
    var list = json['course_session'] as List;
    List<CourseSession> courseSessionList = list
        .map((i) => CourseSession.fromJson(i))
        .toList();
    return MyCourseModel(
      id: json['id'],
      flagPublished: json['flag_published'],
      title: json['title'],
      cover: json['cover'],
      tizer: json['tizer'],
      mentorId: json['mentor_id'],
      categoryCoursesId: json['category_courses_id'],
      flagCertification: json['flag_certification'],
      description: json['description'],
      level: json['level'],
      price: json['price'],
      discountPrice: json['discount_price'],
      discountUntil: json['discount_until'],
      percent: json['percent'],
      totalCount: json['total_count'],
      viewCount: json['view_count'],
      pivot: Pivot.fromJson(json['pivot']),
      mentor: MentorModel.fromJson(json['mentor']),
      courseSession: courseSessionList,
      courseCustomerSession: (json['course_customer_session'] as List?) ?? [],
    );
  }
}

class Pivot {
  final String customerId;
  final String courseId;

  Pivot({required this.customerId, required this.courseId});

  Map<String, dynamic> toJson() {
    return {'customer_id': customerId, 'course_id': courseId};
  }

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(customerId: json['customer_id'], courseId: json['course_id']);
  }
}

class CourseSession {
  final int id;
  final String title;
  final String duration;
  final String video;
  final String group;
  final String locked;
  final String courseId;
  final DateTime createdAt;
  final DateTime updatedAt;

  CourseSession({
    required this.id,
    required this.title,
    required this.duration,
    required this.video,
    required this.group,
    required this.locked,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseSession.fromJson(Map<String, dynamic> json) {
    return CourseSession(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      video: json['video'],
      group: json['group'],
      locked: json['locked'],
      courseId: json['course_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'video': video,
      'group': group,
      'locked': locked,
      'course_id': courseId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
