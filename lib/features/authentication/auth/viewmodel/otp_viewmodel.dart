import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../state/otp_state.dart';

class OtpViewmodel extends StateNotifier<OtpState> {
  OtpViewmodel() : super(OtpState.initial());
  Timer? _timer;

  void updateOtp(String value) {
    state = state.copyWith(otpCode: value, hasError: false);
  }

  void startTimer() {
    state = state.copyWith(counter: 10);
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.counter <= 1) {
        timer.cancel();
        state = state.copyWith(counter: 0, isResendAvailable: true);
      } else {
        state = state.copyWith(counter: state.counter - 1);
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<void> verifyOtp({required String phoneNumber}) async {
    state = state.copyWith(isLoading: true, hasError: false, isVerified: false);

    // await Future.delayed(const Duration(seconds: 2));

    if (state.otpCode == "123456") {
      state = state.copyWith(
        isLoading: false,
        isVerified: true,
        hasError: false,

      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
    } else {
      state = state.copyWith(
        isLoading: false,
        isVerified: false,
        hasError: true,
      );
    }
  }

  Future<void> resendCode(String phoneNumber) async {
    // 1. ریست وضعیت‌ها
    state = state.copyWith(isLoading: true, hasError: false, isVerified: false);

    try {
      /// 2. شبیه‌سازی ارسال مجدد به سرور (در پروژه واقعی: API call می‌زنی)
      await Future.delayed(
        const Duration(seconds: 2),
      );


      startTimer();

      state = state.copyWith(isLoading: false, isResendAvailable: false);
    } catch (e) {
      // در صورت خطا
      state = state.copyWith(isLoading: false, hasError: true);
    }
  }
}
