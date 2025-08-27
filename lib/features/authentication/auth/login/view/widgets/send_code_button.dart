import 'package:daneshyar/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/send_code_provider.dart';

class SendCodeButton extends ConsumerWidget {
  const SendCodeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendCodeViewModelProvider);
    final notifier = ref.read(sendCodeViewModelProvider.notifier);

    return SizedBox(
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
            : const Text(AppStrings.sendCodeSubmitPhoneNumber),
      ),
    );
  }
}
