


import 'package:daneshyar/features/home/state/home_state.dart';
import 'package:daneshyar/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});


final homeProvider = StateNotifierProvider<HomeViewmodel , HomeState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return HomeViewmodel(repository, ref)..fetchHomeData();
},) ;