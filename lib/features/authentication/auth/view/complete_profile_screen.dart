import 'dart:io';

import 'package:daneshyar/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/complete_profile_provider.dart';

class CompleteProfileScreen extends ConsumerWidget {
  final String phoneNumber;

  const CompleteProfileScreen({super.key,required this.phoneNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(completeProfileViewmodelProvider);
    final profileViewModel = ref.read(
      completeProfileViewmodelProvider.notifier,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileViewModel.setPhoneNumber(phoneNumber);
    });
    final theme = Theme.of(context);
    final themeData = theme.textTheme;
    final themeColor = theme.colorScheme;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 120, 16, 24),
        decoration: BoxDecoration(color: themeColor.surfaceBright),
        child: Column(
          children: [
            Text("مشخصات خود را کامل کنید", style: themeData.headlineMedium),
            const SizedBox(height: 10),
            Text(
              "این اطلاعات صرفاً جهت تکمیل ثبت نام شماست و هیچکس قادر به دیدن اطلاعات شما نخواهد بود.",
              style: themeData.labelSmall!.copyWith(
                color: AppColors.lightBorder,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 54),
            SizedBox(
              height: 120,
              width: 120,
              child: CircleAvatar(
                backgroundImage: profileState.imagePath != null
                    ? FileImage(File(profileState.imagePath!))
                    : const AssetImage(
                        "assets/images/completeProfile/ChangeProfile.png",
                      ),
                child: GestureDetector(
                  onTap: () => profileViewModel.pickImage(),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/completeProfile/Edit.png")
                              as ImageProvider,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "نام و ناخانوادگی",
                style: themeData.titleSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              onChanged: profileViewModel.updateFullName,
              decoration: const InputDecoration(
                hintText: "اطلاعات را وارد کنید",
                // errorText: profileState.fullName.trim().isEmpty?"وارد کردن نام اجباری است":null,
                // errorStyle: TextStyle(),
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: profileState.fullName.length < 3
                    ? null
                    : () async {
                        await profileViewModel.submitProfile(phoneNumber);
                        Future.microtask(() {
                          if (ref
                                  .read(completeProfileViewmodelProvider)
                                  .isCompleted &&
                              context.mounted) {
                            Navigator.pushReplacementNamed(
                              context,
                              "/mainScreen",
                            );
                          }
                        });
                      },
                child: profileState.isLoading
                    ? CircularProgressIndicator(
                        color: themeColor.primaryFixedDim,
                      )
                    : const Text("ثبت مشخصات"),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
