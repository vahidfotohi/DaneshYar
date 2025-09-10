import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/appbar_state.dart';
import '../viewmodel/appbar_viewmodel.dart';

final appbarViewmodelProvider =
    StateNotifierProvider<AppBarViewModel, AppBarState>(
      (ref) => AppBarViewModel(),
    );
