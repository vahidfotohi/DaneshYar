import 'package:daneshyar/core/network/network_providers.dart';
import 'package:daneshyar/features/mentor/state/mentor_state.dart';
import 'package:daneshyar/features/mentor/viewmodel/mentor_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorProvider = StateNotifierProvider<MentorViewmodel , MentorState>((ref) {
  final repository = ref.watch(mentorRepositoryProvider);
  return MentorViewmodel(repository);
},);