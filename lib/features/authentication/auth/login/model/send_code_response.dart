class SendCodeResponse {
  final bool status;
  final Data data;
  final dynamic error;

  SendCodeResponse({
    required this.status,
    required this.data,
    required this.error,
  });

  factory SendCodeResponse.fromJson(Map<String, dynamic> json) {
    return SendCodeResponse(
      status: json['status'] ?? false,
      data: Data.fromJson(json['data']),
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data.toJson(), 'error': error};
  }
}

class Data {
  final String type;
  final String loginCode;

  Data({required this.type, required this.loginCode});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      type: json['type'],
      loginCode: json['login_code'],
    );
  }

  toJson() {
    return {'login_code': loginCode};
  }
}
