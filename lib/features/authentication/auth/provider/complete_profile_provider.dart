import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/complete_profile_state.dart';
import '../viewmodel/complete_profile_viewmodel.dart';

final completeProfileViewmodelProvider =
    StateNotifierProvider<CompleteProfileViewmodel, CompleteProfileState>(
      (ref) => CompleteProfileViewmodel(ref),
    );
