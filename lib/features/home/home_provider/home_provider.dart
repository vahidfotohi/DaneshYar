import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home_repository/home_repository.dart';
import '../home_state/home_state.dart';
import '../home_viewmodel/home_viewmodel.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

final homeProvider = StateNotifierProvider<HomeViewmodel, HomeState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return HomeViewmodel(repository, ref)..fetchHomeData();
});
