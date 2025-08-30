class OtpState {
  final String otpCode;
  final int counter;
  final bool isLoading;
  final bool isVerified;
  final bool hasError;
  final String userType;
  final bool isResendAvailable;
  final String? errorMessage;

  const OtpState({
    required this.isResendAvailable,
    required this.otpCode,
    required this.counter,
    required this.isLoading,
    required this.isVerified,
    required this.hasError,
    required this.userType,
    this.errorMessage,
  });

  factory OtpState.initial() {
    return const OtpState(
      otpCode: "",
      counter: 120,
      isLoading: false,
      isVerified: false,
      hasError: false,
      isResendAvailable: false,
      errorMessage: null,
      userType: 'register',
    );
  }

  OtpState copyWith({
    String? otpCode,
    String? userType,
    int? counter,
    bool? isLoading,
    bool? isVerified,
    bool? hasError,
    bool? isResendAvailable,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return OtpState(
      otpCode: otpCode ?? this.otpCode,
      userType: userType ?? this.userType,
      counter: counter ?? this.counter,
      isLoading: isLoading ?? this.isLoading,
      isVerified: isVerified ?? this.isVerified,
      hasError: hasError ?? this.hasError,
      isResendAvailable: isResendAvailable ?? this.isResendAvailable,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}
