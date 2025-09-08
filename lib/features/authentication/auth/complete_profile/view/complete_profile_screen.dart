import 'dart:developer' as developer;
import 'dart:io';

import 'package:daneshyar/core/constants/constants.dart';
import 'package:daneshyar/core/constants/strings.dart';
import 'package:daneshyar/core/routes/app_route.dart';
import 'package:daneshyar/features/authentication/auth/complete_profile/state/complete_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/complete_profile_provider.dart';

class CompleteProfileScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const CompleteProfileScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => ref
          .read(completeProfileViewmodelProvider.notifier)
          .setPhoneNumber(widget.phoneNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(completeProfileViewmodelProvider);
    final profileNotifier = ref.read(completeProfileViewmodelProvider.notifier);

    ref.listen<CompleteProfileState>(completeProfileViewmodelProvider, (
        previous,
        next,
        ) {
      if (next.isCompleted) {
        Navigator.pushReplacementNamed(context, AppRoute.mainScreen);
      }
      if (next.hasError && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.errorMessage!,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                // ۱. بخش اسکرول شونده برای جلوگیری از سرریز
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 80), // فاصله از بالای صفحه
                      const _HeaderSection(),
                      const SizedBox(height: 54),
                      _ProfileAvatar(
                        imagePath: profileState.imagePath,
                        onTap: profileNotifier.pickImage,
                      ),
                      const SizedBox(height: 32),
                      _FullNameTextField(
                        onChanged: (value) => profileNotifier.updateFullName(value),
                      ),
                    ],
                  ),
                ),
              ),
              // ۲. دکمه در پایین صفحه باقی می‌ماند
              _SubmitButton(
                isLoading: profileState.isLoading,
                isEnabled: profileState.fullName.length >= 3,
                onPressed: profileNotifier.submitProfile,
              ),
              const SizedBox(height: 24), // فاصله از پایین صفحه
            ],
          ),
        ),
      ),
    );
  }
}

/// HeaderSection
class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          AppStrings.completeProfileHeaderText,
          style: themeData.headlineMedium,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 10),
        Text(
          AppStrings.completeProfileHeaderText2,
          style: themeData.bodySmall!.copyWith(color: AppColors.lightBorder),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center, // چینش وسط
        ),
      ],
    );
  }
}

/// ProfileAvatar
class _ProfileAvatar extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onTap;

  const _ProfileAvatar({required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: CircleAvatar(
        backgroundImage: imagePath != null
            ? FileImage(File(imagePath!))
            : const AssetImage(
          "assets/images/completeProfile/ChangeProfile.png",
        ) as ImageProvider,
        child: GestureDetector(
          onTap: onTap,
          child: const Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/completeProfile/Edit.png",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// FullName Text Field
class _FullNameTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _FullNameTextField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // کشیده شدن در عرض
      children: [
        Text(
          AppStrings.completeProfileInputLabel,
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.right, // ۳. راست‌چین کردن لیبل
        ),
        const SizedBox(height: 8),
        TextField(
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          onChanged: onChanged,
          decoration: const InputDecoration(
            hintText: AppStrings.completeProfileInputHintText,
          ),
        ),
      ],
    );
  }
}

/// Submit Button
class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onPressed;

  const _SubmitButton({
    required this.isLoading,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading || !isEnabled ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(AppStrings.completeProfileSubmit),
      ),
    );
  }
}
