import 'package:daneshyar/core/constants/strings.dart';
import 'package:daneshyar/core/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/send_code_provider.dart';
import 'widgets/phone_number_input.dart';
import 'widgets/send_code_button.dart';
import 'widgets/terms_and_conditions.dart';

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
              AppStrings.sendCodeTopTerm,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 24),
            PhoneNumberInput(phoneController: _phoneController),
            const SizedBox(height: 16),
            const TermsAndConditions(),
            const SendCodeButton(),
          ],
        ),
      ),
    );
  }
}
