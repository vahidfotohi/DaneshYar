class OtpVerifyResponse {
  final bool status;
  final Data data;
  final dynamic errorCode;
  final dynamic errorMessage;

  OtpVerifyResponse({
    required this.status,
    required this.data,
    required this.errorCode,
    required this.errorMessage,
  });

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerifyResponse(
      status: json['status'] ?? false,
      data: Data.fromJson(json['data']),
      errorCode: json['error_code'],
      errorMessage: json['error_message'],
    );
  }

}

class Data {
  final String type;
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  Data({
    required this.type,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  static fromJson(json) {
    return Data(
      type: json['type'] ?? '',
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
      expiresIn: json['expires_in'] ?? 0,
    );
  }

}
