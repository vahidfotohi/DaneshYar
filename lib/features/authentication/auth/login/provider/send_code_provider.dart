import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/network/network_providers.dart';
import '../state/send_code_state.dart';
import '../viewmodel/send_code_viewmodel.dart';


final sendCodeViewModelProvider =
    StateNotifierProvider<SendCodeViewmodel, SendCodeState>(
      (ref) {
        final authRepository = ref.watch(authRepositoryProvider);
        return SendCodeViewmodel(authRepository);
      },
    );
