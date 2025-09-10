class MentorRequest {
  final int mentorId;

  MentorRequest({
    required this.mentorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'mentor_id': mentorId,
    };
  }

}
