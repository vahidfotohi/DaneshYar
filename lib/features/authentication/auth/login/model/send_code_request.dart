class SendCodeRequest {
  final String phoneNumber;

  SendCodeRequest({required this.phoneNumber});

  factory SendCodeRequest.fromJson(Map<String, dynamic> json) {
    return SendCodeRequest(
      phoneNumber: json['phone_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
    };
  }
}