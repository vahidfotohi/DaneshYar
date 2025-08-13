class LoginState {
  final String phoneNumber;
  final String? phoneError;
  final bool hasError;

  LoginState({this.phoneNumber = "", this.phoneError, this.hasError = false});

  LoginState copyWith({
    String? phoneNumber,
    String? phoneError,
    bool? hasError,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneError: phoneError ?? this.phoneError,
      hasError: hasError ?? this.hasError,
    );
  }
}
