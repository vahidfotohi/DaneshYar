class AppBarState {
  final String fullName;
  final bool hasNotifications;

  AppBarState({
    required this.fullName,
    required this.hasNotifications,
  });

  factory AppBarState.initial() {
    return AppBarState(
      fullName: '',
      hasNotifications: false,
    );
  }

  AppBarState copyWith({
    String? fullName,
    bool? hasNotifications,
  }) {
    return AppBarState(
      fullName: fullName ?? this.fullName,
      hasNotifications: hasNotifications ?? this.hasNotifications,
    );
  }
}
