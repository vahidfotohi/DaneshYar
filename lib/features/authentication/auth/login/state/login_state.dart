class LoginState {
  final String phoneNumber;
  final String? errorMessage;
  final bool hasError;
  final bool isLoading;

  const LoginState({
    required this.phoneNumber, 
    this.errorMessage, 
    required this.hasError,
    required this.isLoading
  });

  factory LoginState.initial() {
    return const LoginState(
      phoneNumber: "",
      isLoading: false,
      hasError: false,
      errorMessage: null,
    );
  }

  LoginState copyWith({
    String? phoneNumber,
    String? errorMessage,
    bool? hasError,
    bool? isLoading,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}