import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/login_state.dart';
import '../viewmodel/login_viewmodel.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewmodel, LoginState>(
      (ref) => LoginViewmodel(),
    );
