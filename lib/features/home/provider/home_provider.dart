import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/network_providers.dart';
import '../state/home_state.dart';
import '../viewmodel/home_viewmodel.dart';

final homeProvider = StateNotifierProvider<HomeViewmodel, HomeState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return HomeViewmodel(repository, ref)..fetchHomeData();
});
