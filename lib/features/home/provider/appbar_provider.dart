import 'package:daneshyar/features/home/state/appbar_state.dart';
import 'package:daneshyar/features/home/viewmodel/appbar_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appbarViewmodelProvider =
    StateNotifierProvider<AppBarViewModel, AppBarState>(
      (ref) => AppBarViewModel(),
    );
