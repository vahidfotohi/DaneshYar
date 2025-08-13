// lib/features/home/viewmodel/appbar_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/appbar_state.dart';

class AppBarViewModel extends StateNotifier<AppBarState> {
  AppBarViewModel() : super(AppBarState.initial());

  void loadUserData({required String fullName}) {
    state = state.copyWith(fullName: fullName);
  }

  void updateNotifications(bool hasNewNotifications) {
    state = state.copyWith(hasNotifications: hasNewNotifications);
  }
}
