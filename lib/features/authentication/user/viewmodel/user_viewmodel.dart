import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../state/user_state.dart';

class UserViewmodel extends StateNotifier<UserState> {
  UserViewmodel() : super(UserState.initial());



  void setUser(UserModel user){
    state= state.copyWith(user: user);
    _saveUserToPrefs(user);
  }
  Future<void> _saveUserToPrefs(UserModel user) async{
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString("user", userJson);
  }

  Future<void> loadUserFromPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("user");
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      final user = UserModel.fromJson(userMap);
      state = state.copyWith(user: user);
    }
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");
    state = UserState.initial();
  }

}
