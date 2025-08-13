import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/login_state.dart';

class LoginViewmodel extends StateNotifier<LoginState> {
  LoginViewmodel() : super(LoginState(phoneNumber: '', phoneError: "",));

  void onPhoneChanged(String value) {
    state = state.copyWith(phoneNumber: value , phoneError: "" ,hasError: false);
  }

  void sendOtp(BuildContext context) async {
    final phone = state.phoneNumber.trim();

    if (phone.length != 11) {
      state = state.copyWith(phoneError: "شماره موبایل معتبر نیست");
      return;
    } else if (!phone.startsWith("09")) {
      state=state.copyWith(phoneError: "لطفا شماره موبایل با 09 شروع شود");
      return;
    }


    Navigator.pushNamed(context, "/otp", arguments: phone);
  }
}
