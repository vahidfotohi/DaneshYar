class UserModel {
  final String id;
  final String fullName;
  final String? imagePath;
  final String phone;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.imagePath,
  });

  // bool get isProfileCompleted => fullName.isNotEmpty && imagePath != null;

  factory UserModel.initial() =>
      const UserModel(fullName: "", phone: "", imagePath: null, id: "");

  UserModel copyWith({
    String? fullName,
    String? imagePath,
    String? phone,
    String? id,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'imagePath': imagePath,
      'phone': phone,
      'id': id,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      imagePath: json['imagePath'],
      phone: json['phone'] ?? '',
      id: json['id'] ?? '',
    );
  }
}
