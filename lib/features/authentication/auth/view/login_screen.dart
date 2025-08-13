import 'package:daneshyar/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _phoneController;
  @override
  void initState() {
    final phone = ref.read(loginViewModelProvider).phoneNumber;
    _phoneController = TextEditingController(text: phone);
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context,) {
    final viewModel = ref.watch(loginViewModelProvider);
    final viewModelNotifier = ref.read(loginViewModelProvider.notifier);
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
              onChanged: (value) => viewModelNotifier.onPhoneChanged(value),
              decoration: InputDecoration(
                hintText: "09********",
                hintStyle: const TextStyle(color: AppColors.hintText),
                suffixIcon: const Icon(
                  Icons.phone_iphone_outlined,
                  size: 24,
                  color: Colors.black,
                ),
                error: viewModel.phoneError!.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          viewModel.phoneError!,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : null,


                prefixIcon: viewModel.phoneNumber.length >= 11
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
                            viewModelNotifier.onPhoneChanged('');
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
                    viewModel.phoneNumber.length < 11
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),

                onPressed: () {
                  if (viewModel.phoneNumber.length >= 11) {
                    viewModelNotifier.sendOtp(context);
                  }
                },
                child: const Text("ثبت شماره موبایل"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
