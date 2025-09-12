class HomeResponse {
  final bool status;
  final HomeData? data;
  final String? errorMessage;

  HomeResponse({required this.status, this.data, this.errorMessage});

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      status: json['status'] ?? false,
      data: json['status'] == true && json['data'] != null
          ? HomeData.fromJson(json['data'])
          : null,
      errorMessage: json['error_message'] as String?,
    );
  }
}

class HomeData {
  final CustomerData customer;
  final List<CategoryData> categories;
  final List<CourseData> courses;
  final List<MentorData> mentors;

  HomeData({
    required this.customer,
    required this.categories,
    required this.courses,
    required this.mentors,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    // استفاده از List.from و map برای خواندن امن لیست‌ها
    final categoriesList = (json['categories'] as List<dynamic>?) ?? [];
    final coursesList = (json['courses'] as List<dynamic>?) ?? [];
    final mentorsList = (json['mentors'] as List<dynamic>?) ?? [];

    return HomeData(
      customer: CustomerData.fromJson(json['customer'] ?? {}),
      categories: categoriesList.map((cat) => CategoryData.fromJson(cat)).toList(),
      courses: coursesList.map((course) => CourseData.fromJson(course)).toList(),
      mentors: mentorsList.map((mentor) => MentorData.fromJson(mentor)).toList(),
    );
  }
}

class CustomerData {
  final int id;
  final String fullname;
  final String phone;
  final String avatar;

  CustomerData({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.avatar,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? '',
      phone: json['phone'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}

class CategoryData {
  final int id;
  final String title;
  final String icon;

  CategoryData({required this.id, required this.title, required this.icon});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class CourseData {
  final int id;
  final String flagPublished;
  final String title;
  final String cover;
  final String tizer;
  final String price;
  final MentorData mentor;
  final String? discountUntil;
  final String? discountPrice;
  final String categoryCoursesId;
  final bool flagCertification;
  final String description;
  final String level;

  CourseData({
    required this.id,
    required this.flagPublished,
    required this.title,
    required this.cover,
    required this.price,
    required this.mentor,
    required this.tizer,
    this.discountUntil,
    this.discountPrice,
    required this.categoryCoursesId,
    required this.flagCertification,
    required this.description,
    required this.level,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'] ?? 0,
      flagPublished: json['flag_published'] ?? '0',
      title: json['title'] ?? '',
      cover: json['cover'] ?? '',
      price: json['price']?.toString() ?? '0',
      mentor: MentorData.fromJson(json['mentor'] ?? {}),
      tizer: json['tizer'] ?? '',
      discountUntil: json['discount_until'] as String?, // اصلاح برای پذیرش null
      discountPrice: json['discount_price'] as String?, // اصلاح برای پذیرش null
      categoryCoursesId: json['category_courses_id']?.toString() ?? '0',
      flagCertification: json['flag_certification'] ?? false,
      description: json['description'] ?? '',
      level: json['level'] ?? '',
    );
  }
}

class MentorData {
  final int id;
  final String name;
  final String avatar;
  final String? bio;
  final String phoneNumber;
  final String wallet;
  final String iban;
  final String? creditName;
  final String? description;
  final int? creditNumber;
  final bool verified;
  final bool active;

  // ۱. استفاده از سازنده با پارامترهای نام‌گذاری شده (Named Constructor)
  MentorData({
    required this.id,
    required this.name,
    required this.avatar,
    this.bio,
    required this.phoneNumber,
    required this.wallet,
    required this.iban,
    this.creditName,
    this.description,
    this.creditNumber,
    required this.verified,
    required this.active,
  });

  factory MentorData.fromJson(Map<String, dynamic> json) {
    return MentorData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      bio: json['bio'] as String?,
      // ۲. اصلاح اشتباه تایپی از 'ph' به 'phone_number'
      phoneNumber: json['phone_number'] ?? '',
      wallet: json['wallet']?.toString() ?? '',
      iban: json['iban']?.toString() ?? '',
      creditName: json['credit_name'] as String?,
      description: json['description'] as String?,
      creditNumber: json['credit_number'] as int?,
      verified: json['verified'] ?? false,
      active: json['active'] ?? false,
    );
  }
}
