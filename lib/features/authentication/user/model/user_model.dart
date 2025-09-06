class UserModel {
  final String id;
  final String fullName;
  final String? avatar;
  final String phone;
  final bool active;
  final bool registered;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.avatar,
    this.active = false,
    this.registered = false,
  });

  // bool get isProfileCompleted => fullName.isNotEmpty && imagePath != null;

  factory UserModel.initial() => const UserModel(
    fullName: "",
    phone: "",
    avatar: null,
    id: "",
    active: false,
    registered: false,
  );

  UserModel copyWith({
    String? fullName,
    String? avatar,
    String? phone,
    String? id,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'avatar': avatar,
      'phone': phone,
      'id': id,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      avatar: json['avatar'],
      phone: json['phone'] ?? '',
      id: json['id'] ?? '',
    );
  }
}
