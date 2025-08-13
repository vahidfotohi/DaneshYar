import 'dart:io';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../user/model/user_model.dart';
import '../../user/provider/user_provider.dart';
import '../state/complete_profile_state.dart';

class CompleteProfileViewmodel extends StateNotifier<CompleteProfileState> {
  final Ref ref;

  CompleteProfileViewmodel(this.ref) : super(CompleteProfileState.initial());
  UserModel? _user;

  UserModel? get user => _user;

  void updateFullName(String value) {
    state = state.copyWith(fullName: value, hasError: false);
  }

  void setPhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(pickedImage.path);
      final savedImage = await File(
        pickedImage.path,
      ).copy("${appDir.path}/$fileName");
      state = state.copyWith(imagePath: savedImage.path);
    }
  }

  Future<void> submitProfile(String phoneNumber) async {
    if (state.fullName.length < 3) {
      state = state.copyWith(hasError: true);
      return;
    }
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 2));
    // if(state.fullName.)
    ///Todo call api
    ref
        .read(userProvider.notifier)
        .setUser(
          _user = UserModel(
            fullName: state.fullName,
            phone: state.phoneNumber,
            imagePath: state.imagePath,
            id: "id",
          ),
        );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_profile_completed', true);
    state = state.copyWith(isLoading: false, isCompleted: true);
  }
}
