class SendCodeState {
  final String phoneNumber;
  final String? errorMessage;
  final bool hasError;
  final bool isLoading;
  final bool navigateToOtp;
  final String? loginCode;
  final String? userType;

  const SendCodeState({
    required this.phoneNumber,
    required this.hasError,
    required this.isLoading,
    this.errorMessage,
    this.loginCode,
    this.userType,
    this.navigateToOtp = false,
  });

  factory SendCodeState.initial() {
    return const SendCodeState(
      phoneNumber: "",
      isLoading: false,
      hasError: false,
      navigateToOtp: false,
    );
  }

  SendCodeState copyWith({
    String? phoneNumber,
    String? errorMessage,
    bool? hasError,
    bool? isLoading,
    bool? navigateToOtp,
    String? loginCode,
    String? userType,
  }) {
    return SendCodeState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
      isLoading: isLoading ?? this.isLoading,
      navigateToOtp: navigateToOtp ?? this.navigateToOtp,
      loginCode: loginCode ?? this.loginCode,
      userType: userType ?? this.userType
    );
  }
}
