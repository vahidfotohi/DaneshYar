
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daneshyar/core/utils/validators.dart';

import '../../repository/auth_repository.dart';
import '../../../../../core/network/error_mapper.dart';
import '../state/send_code_state.dart';
import 'dart:developer' as developer;

class SendCodeViewmodel extends StateNotifier<SendCodeState> {
  final AuthRepository _authRepository;

  SendCodeViewmodel(this._authRepository) : super(SendCodeState.initial());

  void onPhoneChanged(String value) {
    state = state.copyWith(
      phoneNumber: value,
      errorMessage: null,
      hasError: false,
    );
  }

  Future<void> sendOtp() async {
    final phone = state.phoneNumber.trim();
    final validationError = AppValidators.validatePhoneNumber(phone);
    if (validationError != null) {
      state = state.copyWith(errorMessage: validationError, hasError: true);
      return;
    }
    state = state.copyWith(
      isLoading: true,
      hasError: false,
      errorMessage: null,
    );

    try {
      final loginCode = await _authRepository.sendCode(phoneNumber: phone);
      developer.log(loginCode);
      state = state.copyWith(loginCode: loginCode, navigateToOtp: true);
    } catch (e) {
      String errorMessage = "خطا در ارسال کد تایید";
      if (e is PrettyError) {
        errorMessage =  "خطا در اتصال به شبکه لطفا دوباره تلاش کنید";
      }
      state = state.copyWith(errorMessage: errorMessage, hasError: true);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void onNavigationComplete() {
    state = state.copyWith(navigateToOtp: false);
  }
}
