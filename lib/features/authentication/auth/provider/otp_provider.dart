
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/otp_state.dart';
import '../viewmodel/otp_viewmodel.dart';

final otpViewModelProvider = StateNotifierProvider<OtpViewmodel, OtpState>(
  (ref) => OtpViewmodel(),
);
