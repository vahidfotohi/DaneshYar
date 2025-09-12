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
  final String loginCode;

  Data({ required this.loginCode});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      loginCode: json['login_code'],
    );
  }

  Map<String, String> toJson() {
    return {'login_code': loginCode};
  }
}
