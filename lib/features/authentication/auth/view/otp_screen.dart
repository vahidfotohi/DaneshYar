import 'dart:async';

import 'package:daneshyar/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../provider/otp_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(otpViewModelProvider.notifier).startTimer();
    });
    // ref.read(otpViewModelProvider.notifier).startTimer();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    super.dispose();
    ref.read(otpViewModelProvider.notifier).stopTimer();
    errorController.close();
  }

  // final String _otpCode = "";

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(otpViewModelProvider);
    final otpViewModel = ref.read(otpViewModelProvider.notifier);

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
                    const TextSpan(text: "کد ارسال شده به شماره "),
                    TextSpan(
                      text: widget.phoneNumber,
                      style: TextStyle(color: themeColor.primaryFixed),
                    ),
                    const TextSpan(text: " را وارد کنید"),
                  ],
                ),
              ),
              const SizedBox(height: 42),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "کد تایید",
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
                  onChanged: (value) => setState(() {
                    otpViewModel.updateOtp(value);
                  }),
                  onCompleted: (value) {},
                ),
              ),
              if (otpState.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "کد وارد شده صحیح نیست.",
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
                          "ویرایش شماره موبایل",
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
                  !otpState.isResendAvailable
                      ? Row(
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
                              " تا دریافت مجدد کد",
                              style: themeData.bodySmall!.copyWith(
                                fontSize: 10,
                                color: AppColors.lightBorder,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            TextButton.icon(
                              onPressed: () async {
                                await ref
                                    .read(otpViewModelProvider.notifier)
                                    .resendCode(widget.phoneNumber);
                              },
                              icon: const Icon(Icons.refresh),
                              label: Text(
                                "ارسال مجدد کد",
                                style: TextStyle(color: themeColor.primary),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
              const Spacer(),
              // lightBorderconst SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: otpState.isLoading
                      ? null
                      : () async {
                          await otpViewModel.verifyOtp(
                            phoneNumber: widget.phoneNumber,
                          );
                          if (!mounted) return;
                          final isCompleted = ref
                              .read(otpViewModelProvider)
                              .isVerified;
                          final hasError = ref
                              .read(otpViewModelProvider)
                              .hasError;
                          if (isCompleted && context.mounted) {
                            otpViewModel.stopTimer();
                            Navigator.pushReplacementNamed(
                              context,
                              "/completeProfile",
                              arguments: {'phoneNumber': widget.phoneNumber},
                            );
                          } else if (hasError) {
                            errorController.add(ErrorAnimationType.shake);
                          }
                          // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          //   if (!context.mounted) return;
                          //   final isCompleted = ref.read(otpViewModelProvider).isVerified;
                          //   if (isCompleted) {
                          //     Navigator.pushReplacementNamed(context, "/completeProfile");
                          //   }
                          // },);
                          // Future.microtask(() {
                          //   if (ref.read(otpViewModelProvider).isVerified && context.mounted) {
                          //     Navigator.pushReplacementNamed(
                          //       context,
                          //       "/completeProfile",
                          //     );
                          //     otpViewModel.stopTimer();
                          //   } else if (ref.read(otpViewModelProvider).hasError) {
                          //     errorController.add(ErrorAnimationType.shake);
                          //   }
                          // });
                        },

                  child: otpState.isLoading
                      ? CircularProgressIndicator(color: themeColor.primary)
                      : Text(
                          "تایید",
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
