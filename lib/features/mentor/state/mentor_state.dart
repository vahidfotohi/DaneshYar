import '../model/mentor_model.dart';

class MentorState {
  final bool isLoading;
  final String? errorMessage;
  final List<MentorModel> mentors;
  final MentorModel? mentor;
  final bool hasError;

  MentorState({
    this.isLoading = false,
    this.errorMessage,
    this.mentors = const [],
    this.hasError = false,
    this.mentor
  });

  factory MentorState.initial() {
    return MentorState(
      isLoading: false,
      errorMessage: null,
      hasError: false,
      mentors: [],
      mentor: null
    );
  }

  MentorState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<MentorModel>? mentors,
    bool? hasError,
    MentorModel? mentor
  }) {
    return MentorState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      mentors: mentors ?? this.mentors,
      hasError: hasError ?? this.hasError,
      mentor: mentor ?? this.mentor
    );
  }
}
