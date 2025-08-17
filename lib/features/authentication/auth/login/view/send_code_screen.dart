import 'package:daneshyar/core/constants/constants.dart';
import 'package:daneshyar/core/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/validators.dart';
import '../provider/send_code_provider.dart';
import '../state/send_code_state.dart';
import '../viewmodel/send_code_viewmodel.dart';

class SendCodeScreen extends ConsumerStatefulWidget {
  const SendCodeScreen({super.key});

  @override
  ConsumerState<SendCodeScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SendCodeScreen> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    final phone = ref.read(sendCodeViewModelProvider).phoneNumber;
    _phoneController = TextEditingController(text: phone);
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(sendCodeViewModelProvider, (previous, next) {
      if (next.navigateToOtp) {
        Navigator.pushNamed(
          context,
          AppRoute.otp,
          arguments: {
            'phoneNumber': next.phoneNumber,
            'loginCode': next.loginCode,
          },
        );
        ref.read(sendCodeViewModelProvider.notifier).onNavigationComplete();
      }
    });
    final state = ref.watch(sendCodeViewModelProvider);
    final notifier = ref.read(sendCodeViewModelProvider.notifier);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceBright,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "لطفا شماره موبایل خود را وارد کنید.",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 24),
            Text(
              "شماره موبایل",
              textDirection: TextDirection.rtl,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLength: 11,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.rtl,
              controller: _phoneController,
              onChanged: (value) => notifier.onPhoneChanged(value),
              decoration: InputDecoration(
                hintText: "09********",
                hintStyle: const TextStyle(color: AppColors.hintText),
                suffixIcon: const Icon(
                  Icons.phone_iphone_outlined,
                  size: 24,
                  color: Colors.black,
                ),
                error: state.hasError && state.errorMessage != null
                    ? Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            state.errorMessage!,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(color: Colors.red , fontSize: 12),
                          ),
                        ),
                    )
                    : null,

                prefixIcon: state.phoneNumber.length >= 11
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 13),
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            _phoneController.clear();
                            notifier.onPhoneChanged('');
                          },
                          icon: const Icon(
                            Icons.clear_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RichText(
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  children: [
                    const TextSpan(text: "با ثبت نام در دانشیار "),
                    TextSpan(
                      text: "شرایط و قوانین عضویت ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    ),
                    const TextSpan(text: "را می پذیرم."),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    state.phoneNumber.length < 11 || state.isLoading
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),

                onPressed: state.isLoading ? null : notifier.sendOtp,
                child: state.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("ثبت شماره موبایل"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Text(
    "برای ورود یا ثبت‌نام، شماره موبایل خود را وارد کنید.",
    style: Theme.of(context).textTheme.headlineMedium,
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
  );
}

Widget _buildPhoneNumberField(
  BuildContext context,
  SendCodeState state,
  SendCodeViewmodel notifier,
) {
  return TextField(
    maxLength: 11,
    textAlign: TextAlign.center,
    keyboardType: TextInputType.phone,
    onChanged: notifier.onPhoneChanged,
    decoration: InputDecoration(
      labelText: "شماره موبایل",
      hintText: "09123456789",
      // ۶. استفاده از errorText برای نمایش خطا
      errorText: state.hasError ? state.errorMessage : null,
    ),
  );
}

Widget _buildTermsAndConditions(BuildContext context) {
  return RichText(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
    text: TextSpan(
      style: Theme.of(context).textTheme.bodyMedium,
      children: [
        const TextSpan(text: "با ورود و یا ثبت نام در دانشیار، شما "),
        TextSpan(
          text: "شرایط و قوانین ",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        const TextSpan(text: "ما را می‌پذیرید."),
      ],
    ),
  );
}

Widget _buildSubmitButton(
  BuildContext context,
  SendCodeState state,
  SendCodeViewmodel notifier,
) {
  // ۷. منطق فعال/غیرفعال بودن دکمه
  final bool isValid =
      AppValidators.validatePhoneNumber(state.phoneNumber) == null;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16),
    ),
    // ۸. ساده‌سازی onPressed
    onPressed: (isValid && !state.isLoading) ? notifier.sendOtp : null,
    child: state.isLoading
        ? const CircularProgressIndicator(color: Colors.white)
        : const Text("ارسال کد تایید"),
  );
}
