
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/auth_repository.dart';
import '../../../../core/network/api_client.dart';
import '../state/otp_state.dart';
import '../viewmodel/otp_viewmodel.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final otpViewModelProvider = StateNotifierProvider<OtpViewmodel, OtpState>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final apiClient = ref.watch(apiClientProvider);
    return OtpViewmodel(authRepository, apiClient);
  },
);
