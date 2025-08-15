class SendCodeResponse {
  final bool status;
  final String loginCode;
  final String? error;

  SendCodeResponse({
    required this.status,
    required this.loginCode,
    this.error,
  });

  factory SendCodeResponse.fromJson(Map<String, dynamic> json) {
    return SendCodeResponse(
      status: json['status'] ?? false,
      loginCode: json['data']?['login_code'] ?? '',
      error: json['error'],
    );
  }
}
