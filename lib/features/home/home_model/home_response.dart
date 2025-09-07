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
  // شما می‌توانید برای mentors و my_courses هم مدل‌های مشابه بسازید

  HomeData({
    required this.customer,
    required this.categories,
    required this.courses,
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

    return HomeData(
      customer: CustomerData.fromJson(json['customer']),
      categories: categoryList,
      courses: courseList,
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
  final String price;
  final MentorData mentor;

  CourseData({
    required this.id,
    required this.flagPublished,
    required this.title,
    required this.cover,
    required this.price,
    required this.mentor,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'] ?? 0,
      flagPublished: json['flag_published'] ?? '0',
      title: json['title'] ?? '',
      cover: json['cover'] ?? '',
      price: json['price'] ?? '0',
      mentor: MentorData.fromJson(json['mentor'] ?? {}),
    );
  }
}

class MentorData {
  final int id;
  final String name;

  MentorData({required this.id, required this.name});

  factory MentorData.fromJson(Map<String, dynamic> json) {
    return MentorData(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'نامشخص',
    );
  }
}