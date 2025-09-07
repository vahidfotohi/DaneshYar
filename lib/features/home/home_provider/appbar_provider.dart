import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home_state/appbar_state.dart';
import '../home_viewmodel/appbar_viewmodel.dart';

final appbarViewmodelProvider =
    StateNotifierProvider<AppBarViewModel, AppBarState>(
      (ref) => AppBarViewModel(),
    );
