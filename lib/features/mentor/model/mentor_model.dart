class MentorModel {
  final int id;
  final String name;
  final String avatar;
  final String bio;
  final String phoneNumber;
  final String wallet;
  final String iban;
  final String? creditName;
  final int? creditNumber;
  final String? description;
  final bool verified;
  final bool active;

  MentorModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.bio,
    required this.phoneNumber,
    required this.wallet,
    required this.iban,
    this.creditName,
    this.creditNumber,
    this.description,
    required this.verified,
    required this.active,
  });

  factory MentorModel.initial() => MentorModel(
    id: 0,
    name: "",
    avatar: "",
    bio: "",
    phoneNumber: "",
    wallet: "",
    iban: "",
    creditName: null,
    creditNumber: 0,
    description: null,
    verified: false,
    active: false,
  );

  MentorModel copyWith({
    int? id,
    String? name,
    String? avatar,
    String? bio,
    String? phoneNumber,
    String? wallet,
    String? iban,
    String? creditName,
    int? creditNumber,
    String? description,
    bool? verified,
    bool? active,
  }) {
    return MentorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      wallet: wallet ?? this.wallet,
      iban: iban ?? this.iban,
      creditName: creditName ?? this.creditName,
      creditNumber: creditNumber ?? this.creditNumber,
      description: description ?? this.description,
      verified: verified ?? this.verified,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'bio': bio,
      'phone_number': phoneNumber,
      'wallet': wallet,
      'iban': iban,
      'credit_name': creditName,
      'credit_number': creditNumber,
      'description': description,
      'verified': verified,
      'active': active,
    };
  }

  factory MentorModel.fromJson(Map<String, dynamic> json) {
    return MentorModel(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      bio: json['bio'],
      phoneNumber: json['phone_number'],
      wallet: json['wallet'],
      iban: json['iban'],
      creditName: json['credit_name'],
      creditNumber: json['credit_number'],
      description: json['description'],
      verified: json['verified'],
      active: json['active'],
    );
  }

  
}
