import 'dart:io';

import 'package:daneshyar/features/authentication/auth/complete_profile/model/complete_profile_request.dart';
import 'package:daneshyar/features/authentication/auth/login/provider/send_code_provider.dart';
import 'package:daneshyar/features/authentication/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../user/model/user_model.dart';
import '../../../user/provider/user_provider.dart';
import '../state/complete_profile_state.dart';

class CompleteProfileViewmodel extends StateNotifier<CompleteProfileState> {
  final Ref ref;
  final AuthRepository _authRepository;

  CompleteProfileViewmodel(this.ref)
    : _authRepository = ref.watch(authRepositoryProvider),
      super(CompleteProfileState.initial());
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

  Future<void> submitProfile() async {
    if (state.fullName.length < 3) {
      state = state.copyWith(hasError: true);
      return;
    }
    state = state.copyWith(isLoading: true, hasError: false);
    try {
      final request = CompleteProfileRequest(
        fullName: state.fullName,
        avatar: state.imagePath,
      );
      final response = await _authRepository.completeProfile(request: request);
      if (response.status == true) {
        ref
            .read(userProvider.notifier)
            .setUser(
              UserModel(
                id: response.data.id.toString(),
                fullName: response.data.fullName,
                phone: response.data.phone,
                imagePath: response.data.avatar,
              ),
            );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_profile_completed', true);
        state = state.copyWith(isLoading: false, isCompleted: true);
        return;
      } else {
        state = state.copyWith(isLoading: false, hasError: true);
        throw Exception(response.errorMessage ?? 'خطا در تکمیل پروفایل');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, hasError: true);
      rethrow;
    }
  }
}
