class CourseResponse {
  final bool status;
  final List<Data> data;
  final dynamic errorCode;
  final dynamic errorMessage;



  CourseResponse({
    required this.status,
    required this.data,
    required this.errorCode,
    required this.errorMessage,
  });


  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    var dataList = <Data>[];
    if(json['data'] != null && json['data'] is List){
      dataList = (json['data'] as List).map((item) => Data.fromJson(item)).toList();
    }
    return CourseResponse(
      status: json['status'] ?? false,
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
  final String trailer;
  final String mentorId;
  final String categoryCoursesId;
  final bool flagCertification;
  final String description;
  final String level;
  final String price;
  final dynamic discountPrice;
  final dynamic discountUntil;
  final Mentor mentor;

  Data({
    required this.id,
    required this.flagPublished,
    required this.title,
    required this.cover,
    required this.trailer,
    required this.mentorId,
    required this.categoryCoursesId,
    required this.flagCertification,
    required this.description,
    required this.level,
    required this.price,
    required this.discountPrice,
    required this.discountUntil,
    required this.mentor,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] ?? 0,
      flagPublished: json['flag_published'] ?? '',
      title: json['title'] ?? '',
      cover: json['cover'] ?? '',
      trailer: json['tizer'] ?? '',
      mentorId: json['mentor_id'] ?? '',
      categoryCoursesId: json['category_courses_id'] ?? '',
      flagCertification: json['flag_certification'] ?? false,
      description: json['description'] ?? '',
      level: json['level'] ?? '',
      price: json['price'] ?? '',
      discountPrice: json['discount_price'],
      discountUntil: json['discount_until'],
      mentor: json['mentor'] != null ? Mentor.fromJson(json['mentor']) : Mentor.empty(),
    );
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      bio: json['bio'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      wallet: json['wallet'] ?? '',
      iban: json['iban'] ?? '',
      creditName: json['credit_name'],
      creditNumber: json['credit_number'],
      description: json['description'],
      verified: json['verified'] ?? false,
      active: json['active'] ?? false,
    );
  }

  factory Mentor.empty() {
    return Mentor(
      id: 0,
      name: '',
      avatar: '',
      bio: '',
      phoneNumber: '',
      wallet: '',
      iban: '',
      creditName: null,
      creditNumber: null,
      description: null,
      verified: false,
      active: false,
    );
  }

}

