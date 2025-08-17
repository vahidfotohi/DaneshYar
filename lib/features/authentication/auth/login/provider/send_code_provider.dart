import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/auth_repository.dart';
import '../state/send_code_state.dart';
import '../viewmodel/send_code_viewmodel.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final sendCodeViewModelProvider =
    StateNotifierProvider<SendCodeViewmodel, SendCodeState>(
      (ref) {
        final authRepository = ref.watch(authRepositoryProvider);
        return SendCodeViewmodel(authRepository);
      },
    );
