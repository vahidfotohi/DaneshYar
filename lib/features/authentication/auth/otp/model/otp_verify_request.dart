class OtpVerifyRequest {
  final String code;
  final String loginCode;

  OtpVerifyRequest({required this.code, required this.loginCode});

  Map<String, dynamic> toJson() {
    return {'code': code, 'login_code': loginCode};
  }

  factory OtpVerifyRequest.fromJson(Map<String, dynamic> json) {
    return OtpVerifyRequest(
      code: json['code'] ?? '',
      loginCode: json['login_code'] ?? '',
    );
  }
}
