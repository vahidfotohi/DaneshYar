
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/user_state.dart';
import '../viewmodel/user_viewmodel.dart';

final userProvider = StateNotifierProvider<UserViewmodel, UserState>((ref) {
  return UserViewmodel();
});
