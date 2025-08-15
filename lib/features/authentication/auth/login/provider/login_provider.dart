import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/auth_repository.dart';
import '../state/login_state.dart';
import '../viewmodel/login_viewmodel.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final loginViewModelProvider =
    StateNotifierProvider<LoginViewmodel, LoginState>(
      (ref) {
        final authRepository = ref.watch(authRepositoryProvider);
        return LoginViewmodel(authRepository);
      },
    );
