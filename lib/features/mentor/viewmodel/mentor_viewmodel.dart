import 'package:daneshyar/features/mentor/model/mentor_model.dart';
import 'package:daneshyar/features/mentor/state/mentor_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/mentor_repository.dart';

class MentorViewmodel extends StateNotifier<MentorState> {
  final MentorRepository repository;

  MentorViewmodel(this.repository) : super(MentorState.initial());

  void initializeData(List<MentorModel> mentors) {
    state = state.copyWith(mentors: mentors, isLoading: false, hasError: false);
  }

  // void setMentor(MentorModel mentor){
  //   state =state.copyWith(mentors: mentors..add(mentor));
  // }

  Future<MentorModel> mentorById(int mentorId) async {
    state = state.copyWith(isLoading: true);
    try {
      final mentor = await repository.getMentorById(mentorId);
      state = state.copyWith(mentor: mentor, isLoading: false);
      return mentor;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching mentorById: $e");
      }
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      rethrow;
    }
  }
}
