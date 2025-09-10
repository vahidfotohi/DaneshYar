
class MentorResponse {
  final bool status;
  final MentorData data;
  final int? errorCode;
  final String? errorMessage;

  MentorResponse({
    required this.status,
    required this.data,
    this.errorCode,
    this.errorMessage,
  });

  factory MentorResponse.fromJson(Map<String, dynamic> json) {
    return MentorResponse(
      status: json['status'],
      data: MentorData.fromJson(json['data']),
      errorCode: json['errorCode'] as int?,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'status' : status,
      'data' : data.toJson(),
      'errorCode' : errorCode,
      'errorMessage' : errorMessage
    };
  }
}

class MentorData {
  final String fullname;
  final String avatar;
  final String bio;
  final String? description;
  final bool verified;
  final bool active;
  final List<String> comments;

  MentorData({
    required this.fullname,
    required this.avatar,
    required this.bio,
    this.description,
    required this.verified,
    required this.active,
    required this.comments,
  });

  factory MentorData.fromJson(Map<String , dynamic> json){
    return MentorData(
      fullname: json['fullname'] ?? '',
      avatar: json['avatar'] ?? '',
      bio: json['bio'] ?? '',
      description: json['description'],
      verified: json['verified'] ?? false,
      active: json['active'] ?? false,
      comments: List<String>.from(json['comments'] ?? []),
    );
  }

  Map<String , dynamic> toJson(){
    return {
      "fullname": fullname,
      "avatar": avatar,
      "bio": bio,
      "description": description,
      "verified": verified,
      "active": active,
      "comments": comments,
    };
  }
}
