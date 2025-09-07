class HomeState {
  final bool isLoading;
  final String? errorMessage;
  final bool hasError;

  HomeState(this.isLoading, this.errorMessage, this.hasError);

  HomeState.initial()
    : isLoading = false,
      errorMessage = null,
      hasError = false;

  HomeState copyWith({bool? isLoading, String? errorMessage, bool? hasError}) {
    return HomeState(
      isLoading ?? this.isLoading,
      errorMessage ?? this.errorMessage,
      hasError ?? this.hasError,
    );
  }
}
