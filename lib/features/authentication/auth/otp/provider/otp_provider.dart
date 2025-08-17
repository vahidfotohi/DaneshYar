import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../login/provider/send_code_provider.dart';
import '../state/otp_state.dart';
import '../viewmodel/otp_viewmodel.dart';

final otpViewModelProvider =
    StateNotifierProvider.family<OtpViewmodel, OtpState, Map<String, dynamic>>((
      ref,
      arguments,
    ) {
      final authRepository = ref.watch(authRepositoryProvider);
      final phoneNumber = arguments['phoneNumber']!;
      final loginCode = arguments['loginCode']!;
      return OtpViewmodel(
        authRepository: authRepository,
        phoneNumber: phoneNumber,
        loginCode: loginCode,
      );
    });
