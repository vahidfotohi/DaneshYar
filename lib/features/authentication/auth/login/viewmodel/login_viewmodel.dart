import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/auth_repository.dart';
import '../../../../../core/network/error_mapper.dart';
import '../state/login_state.dart';

class LoginViewmodel extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;
  
  LoginViewmodel(this._authRepository) : super(LoginState.initial());

  void onPhoneChanged(String value) {
    state = state.copyWith(phoneNumber: value, errorMessage: null, hasError: false);
  }

  void sendOtp(BuildContext context) async {
    final phone = state.phoneNumber.trim();

    if (phone.length != 11) {
      state = state.copyWith(errorMessage: "شماره موبایل معتبر نیست", hasError: true);
      return;
    } else if (!phone.startsWith("09")) {
      state = state.copyWith(errorMessage: "لطفا شماره موبایل با 09 شروع شود", hasError: true);
      return;
    }
    
    state = state.copyWith(isLoading: true, hasError: false, errorMessage: null);
    
    try {
      await _authRepository.sendCode(phoneNumber: phone);
      if (context.mounted) {
        Navigator.pushNamed(context, "/otp", arguments: phone);
      }
    } catch (e) {
      String errorMessage = "خطا در ارسال کد تایید";
      if (e is PrettyError) {
        errorMessage = e.message;
      }
      state = state.copyWith(errorMessage: errorMessage, hasError: true);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
