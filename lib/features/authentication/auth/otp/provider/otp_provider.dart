import 'package:daneshyar/features/authentication/auth/otp/view/otp_screen_arguments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../login/provider/send_code_provider.dart';
import '../state/otp_state.dart';
import '../viewmodel/otp_viewmodel.dart';

final otpViewModelProvider =
    StateNotifierProvider.family<OtpViewmodel, OtpState, OtpScreenArguments>((
      ref,
      arguments,

    ) {
      final authRepository = ref.watch(authRepositoryProvider);
      return OtpViewmodel(
        authRepository: authRepository,
        phoneNumber: arguments.phoneNumber,
        loginCode: arguments.loginCode,
      );
    });
