class OtpState {
  final String otpCode;
  final int counter;
  final bool isLoading;
  final bool isVerified;
  final bool hasError;
  final bool isResendAvailable;

  const OtpState({
    required this.isResendAvailable,
    required this.otpCode,
    required this.counter,
    required this.isLoading,
    required this.isVerified,
    required this.hasError,
  });

  factory OtpState.initial() {
    return const OtpState(
      otpCode: "",
      counter: 120,
      isLoading: false,
      isVerified: false,
      hasError: false,
      isResendAvailable: false
    );
  }

  OtpState copyWith({
    String? otpCode,
    int? counter,
    bool? isLoading,
    bool? isVerified,
    bool? hasError,
    bool? isResendAvailable
  }) {
    return OtpState(
      otpCode: otpCode ?? this.otpCode,
      counter: counter ?? this.counter,
      isLoading: isLoading ?? this.isLoading,
      isVerified: isVerified ?? this.isVerified,
      hasError: hasError ?? this.hasError,
      isResendAvailable : isResendAvailable ?? this.isResendAvailable
    );
  }
}
