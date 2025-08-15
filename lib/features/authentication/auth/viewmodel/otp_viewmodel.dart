import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/auth/auth_repository.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/error_mapper.dart';

import '../state/otp_state.dart';

class OtpViewmodel extends StateNotifier<OtpState> {
  final AuthRepository _authRepository;
  final ApiClient _apiClient;
  String? _loginCode;
  
  OtpViewmodel(this._authRepository, this._apiClient) : super(OtpState.initial());
  Timer? _timer;

  void updateOtp(String value) {
    state = state.copyWith(otpCode: value, hasError: false, errorMessage: null);
  }

  void startTimer() {
    state = state.copyWith(counter: 120, isResendAvailable: false);
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.counter > 0) {
        state = state.copyWith(counter: state.counter - 1);
      } else {
        stopTimer();
        state = state.copyWith(isResendAvailable: true);
      }
    });
  }
  
  void setLoginCode(String loginCode) {
    _loginCode = loginCode;
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<void> verifyOtp() async {
    state = state.copyWith(isLoading: true, hasError: false, errorMessage: null);
    try {
      // کد ثابت 111111 برای ورود
      if (state.otpCode == "111111") {
        // ذخیره وضعیت ورود کاربر
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        state = state.copyWith(isVerified: true, isLoading: false);
        return;
      }
      
      if (_loginCode == null) {
        throw Exception('کد ورود نامعتبر است. لطفا دوباره تلاش کنید');
      }
      
      await _apiClient.authService.login(
        code: state.otpCode,
        loginCode: _loginCode!,
      );
      
      // ذخیره وضعیت ورود کاربر
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      state = state.copyWith(isVerified: true, isLoading: false);
    } catch (e) {
      String errorMessage = 'خطا در تایید کد';
      if (e is PrettyError) {
        errorMessage = e.message;
      } else if (e is Exception) {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }
      state = state.copyWith(
        hasError: true, 
        isLoading: false,
        errorMessage: errorMessage
      );
    }
  }

  Future<void> resendCode(String phoneNumber) async {
    state = state.copyWith(isResendAvailable: false, hasError: false, errorMessage: null);
    try {
      // برای تست، کد ورود را به 111111 تنظیم می‌کنیم
      // در حالت واقعی، از سرور دریافت می‌شود
      _loginCode = await _apiClient.authService.sendCode(phoneNumber: phoneNumber);
      startTimer();
    } catch (e) {
      String errorMessage = 'خطا در ارسال مجدد کد';
      if (e is PrettyError) {
        errorMessage = e.message;
      } else if (e is Exception) {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }
      state = state.copyWith(
        hasError: true, 
        errorMessage: errorMessage,
        isResendAvailable: true
      );
    }
  }
}
