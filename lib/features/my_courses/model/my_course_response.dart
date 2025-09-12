class MyCourseResponse {
  final bool status;
  final List<Data> data;
  final dynamic errorCode;
  final dynamic errorMessage;

  MyCourseResponse({
    required this.status,
    required this.data,
    required this.errorCode,
    required this.errorMessage,
  });
  factory MyCourseResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return MyCourseResponse(
      status: json['status'],
      data: dataList,
      errorCode: json['error_code'],
      errorMessage: json['error_message'],
    );
  }
}

class Data {
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
  final Mentor mentor;
  final List<CourseSession> courseSession;
  final List<dynamic> courseCustomerSession;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['course_session'] as List;
    List<CourseSession> courseSessionList = list.map((i) => CourseSession.fromJson(i)).toList();

    return Data(
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
      mentor: Mentor.fromJson(json['mentor']),
      courseSession: courseSessionList,
      courseCustomerSession: json['course_customer_session'],
    );
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

  Map<String , dynamic> toJson() {
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

class Mentor {
  final int id;
  final String name;
  final String avatar;
  final String bio;
  final String phoneNumber;
  final String wallet;
  final String iban;
  final dynamic creditName;
  final dynamic creditNumber;
  final dynamic description;
  final bool verified;
  final bool active;

  Mentor({
    required this.id,
    required this.name,
    required this.avatar,
    required this.bio,
    required this.phoneNumber,
    required this.wallet,
    required this.iban,
    required this.creditName,
    required this.creditNumber,
    required this.description,
    required this.verified,
    required this.active,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      bio: json['bio'],
      phoneNumber: json['phone_number'],
      wallet: json['wallet'],
      iban: json['iban'],
      creditName: json['credit_name'],
      creditNumber: json['credit_number'],
      description: json['description'],
      verified: json['verified'],
      active: json['active'],
    );
  }

  Map<String , dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'bio': bio,
      'phone_number': phoneNumber,
      'wallet': wallet,
      'iban': iban,
      'credit_name': creditName,
      'credit_number': creditNumber,
      'description': description,
      'verified': verified,
      'active': active,
    };
  }

}

class Pivot {
  final String customerId;
  final String courseId;

  Pivot({
    required this.customerId,
    required this.courseId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      customerId: json['customer_id'],
      courseId: json['course_id'],
    );
  }

  Map<String , dynamic> toJson() {
    return {
      'customer_id': customerId,
      'course_id': courseId,
    };
  }
}
