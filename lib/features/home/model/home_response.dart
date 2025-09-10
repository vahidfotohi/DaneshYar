// این مدل برای داده‌های خام کاربر، دسته‌بندی و دوره از سرور است
// که بعداً در Repository به مدل‌های تمیز UI تبدیل می‌شوند.

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
      errorMessage: json['error_message'],
    );
  }
}

class HomeData {
  final CustomerData customer;
  final List<CategoryData> categories;
  final List<CourseData> courses;
  final List<MentorData> mentors;

  // شما می‌توانید برای mentors و my_courses هم مدل‌های مشابه بسازید

  HomeData({
    required this.customer,
    required this.categories,
    required this.courses,
    required this.mentors,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    var categoryList = <CategoryData>[];
    if (json['categories'] is List) {
      categoryList = (json['categories'] as List)
          .map((cat) => CategoryData.fromJson(cat))
          .toList();
    }

    var courseList = <CourseData>[];
    if (json['courses'] is List) {
      courseList = (json['courses'] as List)
          .map((course) => CourseData.fromJson(course))
          .toList();
    }

    var mentorList = <MentorData>[];
    if (json['mentors'] is List) {
      mentorList = (json['mentors'] as List)
          .map((mentor) => MentorData.fromJson(mentor))
          .toList();
    }
    return HomeData(
      customer: CustomerData.fromJson(json['customer']),
      categories: categoryList,
      courses: courseList,
      mentors: mentorList,
    );
  }
}

// مدل‌های داده خام از سرور

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
      price: json['price'] ?? '0',
      mentor: MentorData.fromJson(json['mentor'] ?? {}),
      tizer: json['tizer'] ?? '',
      discountUntil: json['discount_until'] ?? '0',
      discountPrice: json['discount_price'] ?? '0',
      categoryCoursesId: json['category_courses_id'] ?? '0',
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

  MentorData(
    this.bio,
    this.wallet,
    this.iban,
    this.creditName,
    this.description,
    this.creditNumber,
    this.verified,
    this.active,
    this.id,
    this.avatar,
    this.phoneNumber,
    this.name,
  );

  factory MentorData.fromJson(Map<String, dynamic> json) {
    return MentorData(
      json['bio'] ?? '',
      json['wallet'] ?? '',
      json['iban'] ?? '',
      json['credit_name'],
      json['description'],
      json['credit_number'],
      json['verified'] ?? false,
      json['active'] ?? false,
      json['id'] ?? 0,
      json['avatar'] ?? '',
      json['ph'] ?? '',
      json['name'] ?? '',
    );
  }
}
