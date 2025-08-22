class CompleteProfileResponse {
  final bool status;
  final Data data;
  final dynamic errorCode;
  final dynamic errorMessage;

  CompleteProfileResponse({
    required this.status,
    required this.data,
    required this.errorCode,
    required this.errorMessage,
  });

  factory CompleteProfileResponse.fromJson(Map<String, dynamic> json) {
    return CompleteProfileResponse(
      status: json['status'] as bool,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      errorCode: json['error_code'],
      errorMessage: json['error_message'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'error_code': errorCode,
      'error_message': errorMessage,
    };
  }

}

class Data {
  final int id;
  final String fullName;
  final String phone;
  final String avatar;
  final bool active;
  final bool registered;

  Data({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.avatar,
    required this.active,
    required this.registered,
  });

  static fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String,
      active: json['active'] as bool,
      registered: json['registered'] as bool,
    );
  }

  toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'avatar': avatar,
      'active': active,
      'registered': registered,
    };
  }

}
