class SendCode {
  final bool status;
  final Data data;
  final dynamic error;

  SendCode({
    required this.status,
    required this.data,
    required this.error,
  });

}

class Data {
  final String loginCode;

  Data({
    required this.loginCode,
  });

}
