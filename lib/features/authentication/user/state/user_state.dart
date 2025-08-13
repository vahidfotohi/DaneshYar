
import '../model/user_model.dart';

class UserState {
  final UserModel? user;

  const UserState({this.user});

  factory UserState.initial() => const UserState(user: null);

  UserState copyWith({UserModel? user}) {
    return UserState(user: user ?? this.user);
  }
}
