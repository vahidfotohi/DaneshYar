import 'dart:async';
import 'package:daneshyar/core/constants/constants.dart';
import 'package:daneshyar/core/constants/strings.dart';
import 'package:daneshyar/core/routes/app_route.dart';
import 'package:daneshyar/features/authentication/auth/otp/view/otp_screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../provider/otp_provider.dart';
import '../state/otp_state.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String loginCode;
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.loginCode,
  });

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final errorController = StreamController<ErrorAnimationType>();
  late final OtpScreenArguments providerArguments;

  @override
  void initState() {
    super.initState();

    providerArguments = OtpScreenArguments(
      phoneNumber: widget.phoneNumber,
      loginCode: widget.loginCode,
    );
    Future.microtask(
      () => ref
          .read(otpViewModelProvider(providerArguments).notifier)
          .initialize(),
    );

    // errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  // final String _otpCode = "";

  @override
  Widget build(BuildContext context) {
    final otpProvider = otpViewModelProvider(providerArguments);
    final otpState = ref.watch(otpProvider);
    final otpNotifier = ref.read(otpProvider.notifier);

    ref.listen<OtpState>(otpProvider, (previous, next) {
      if (next.hasError && !(previous?.hasError ?? false)) {
        errorController.add(ErrorAnimationType.shake);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                next.errorMessage ?? AppStrings.otpSnackBarError,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            ),
          );
      }
      if (next.isVerified) {
        // otpNotifier.stopTimer();
        Navigator.pushReplacementNamed(
          context,
          AppRoute.completeProfile,
          arguments: {'phoneNumber': widget.phoneNumber},
        );
      }
    });

    final themeData = Theme.of(context).textTheme;
    final themeColor = Theme.of(context).colorScheme;

    String formatTime(int totalSeconds) {
      final minutes = totalSeconds ~/ 60;
      final seconds = totalSeconds % 60;
      return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: themeColor.surfaceBright),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            top: 120,
            right: 24,
            bottom: 64,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: themeData.displayMedium,

                  children: [
                    const TextSpan(text: AppStrings.otpTitlePrefix),
                    TextSpan(
                      text: widget.phoneNumber,
                      style: TextStyle(color: themeColor.primaryFixed),
                    ),
                    const TextSpan(text: AppStrings.otpTitleSuffix),
                  ],
                ),
              ),
              const SizedBox(height: 42),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  AppStrings.otpLabel,
                  style: themeData.bodyLarge,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),

              const SizedBox(height: 8),
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  enableActiveFill: false,
                  validator: (value) {
                    if (otpState.hasError) return "";
                    return null;
                  },

                  appContext: context,
                  useHapticFeedback: true,
                  length: 6,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  cursorColor: themeColor.primaryFixed,
                  // obscureText: true,
                  // obscuringCharacter: '*',
                  errorAnimationController: errorController,
                  animationDuration: const Duration(milliseconds: 300),
                  hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    activeColor: themeColor.primaryFixed,
                    inactiveColor: AppColors.lightBorder,
                    selectedColor: themeColor.primary,
                    errorBorderColor: themeColor.error,
                    errorBorderWidth: 1.5,
                    inactiveFillColor: Colors.white,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                  ),
                  onChanged: otpNotifier.onOtpChanged,
                  onCompleted: (value) => otpNotifier.verifyOtp(),
                ),
              ),
              if (otpState.hasError && otpState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    otpState.errorMessage ?? AppStrings.otpInvalidCode,
                    style: TextStyle(color: themeColor.error),
                    textDirection: TextDirection.rtl,
                  ),
                ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.otpEditPhone,
                          style: themeData.bodySmall!.copyWith(
                            color: themeColor.primaryFixed,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.mode_edit_outlined,
                          size: 18,
                          color: themeColor.primaryFixed,
                        ),
                      ],
                    ),
                  ),
                  if (!otpState.isResendAvailable)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      textDirection: TextDirection.rtl,
                      children: [
                        const Icon(
                          Icons.timelapse_outlined,
                          color: AppColors.lightBorder,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          formatTime(otpState.counter),
                          style: TextStyle(color: themeColor.primaryFixed),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          AppStrings.otpResendWait,
                          style: themeData.bodySmall!.copyWith(
                            fontSize: 10,
                            color: AppColors.lightBorder,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        if (otpState.isResendAvailable)
                          TextButton.icon(
                            onPressed: () {
                              otpNotifier.resendCode();
                            },
                            icon: const Icon(Icons.refresh),
                            label: Text(
                              AppStrings.otpResend,
                              style: TextStyle(color: themeColor.primary),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              const Spacer(),
              // lightBorder const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: otpState.isLoading ? null : otpNotifier.verifyOtp,

                  child: otpState.isLoading
                      ? CircularProgressIndicator(color: themeColor.primary)
                      : Text(
                          AppStrings.otpConfirm,
                          style: themeData.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
