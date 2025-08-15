class CompleteProfileState {
  final String fullName;
  final String? imagePath;
  final bool isLoading;
  final bool isCompleted;
  final bool hasError;
  final String phoneNumber;

  const CompleteProfileState({
    required this.fullName,
    required this.phoneNumber,
    required this.imagePath,
    required this.isLoading,
    required this.isCompleted,
    required this.hasError,
  });

  factory CompleteProfileState.initial() {
    return const CompleteProfileState(
      fullName: '',
      imagePath: null,
      isLoading: false,
      isCompleted: false,
      hasError: true,
      phoneNumber: '',
    );
  }

  CompleteProfileState copyWith({
    String? fullName,
    String? imagePath,
    bool? isLoading,
    bool? isCompleted,
    bool? hasError,
    String? phoneNumber,
  }) {
    return CompleteProfileState(
      fullName: fullName ?? this.fullName,
      imagePath: imagePath ?? this.imagePath,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      hasError: hasError ?? this.hasError,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
