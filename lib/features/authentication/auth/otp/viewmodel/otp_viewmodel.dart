import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/validators.dart';
import '../../repository/auth_repository.dart';
import '../../../../../core/network/error_mapper.dart';

import '../state/otp_state.dart';

class OtpViewmodel extends StateNotifier<OtpState> {
  final AuthRepository _authRepository;
  final String phoneNumber;

  String _loginCode;

  Timer? _timer;

  OtpViewmodel({
    required AuthRepository authRepository,
    required this.phoneNumber,
    required String loginCode,
  }) : _authRepository = authRepository,
       _loginCode = loginCode,
       super(OtpState.initial());

  void initialize() {
    startTimer();
  }


  void onOtpChanged(String value) {
    developer.log("changed $value");
    state = state.copyWith(
      otpCode: value,
      hasError: false,
      clearErrorMessage: true,
    );
    developer.log("state value ${state.otpCode}");
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

    developer.log("State Value : ${state.otpCode}");

    // final validationError = AppValidators.validateOtpCode(state.otpCode);
    // if (validationError != null) {
    //   state = state.copyWith(
    //     hasError: true,
    //     errorMessage: validationError,
    //     isLoading: false,
    //   );
    //   return;
    // }
    // state = state.copyWith(
    //   isLoading: true,
    //   hasError: false,
    //   clearErrorMessage: true,
    // );
    // کد ثابت 111111 برای ورود

    if (state.otpCode == "111111") {
      // ذخیره وضعیت ورود کاربر
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(isVerified: true, isLoading: false);
      return;
    }
    try {
      developer.log("call try");
      developer.log("state.code: ${state.otpCode}");

      await _authRepository.verifyOtpAndLogin(
        code: state.otpCode,
        loginCode: _loginCode,
      );
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
        errorMessage: errorMessage,
      );
    }

  }

  Future<void> resendCode() async {
    state = state.copyWith(
      isResendAvailable: false,
      isLoading: true,
      hasError: false,
      errorMessage: null,
    );
    try {
      final newLoginCode = await _authRepository.sendCode(
        phoneNumber: phoneNumber,
      );
      _loginCode = newLoginCode;
      state = state.copyWith(isLoading: false);
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
        isLoading: false,
        errorMessage: errorMessage,
        isResendAvailable: true,
      );
    }
  }


}
