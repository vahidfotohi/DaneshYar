import 'package:daneshyar/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/constants.dart';
import '../../provider/send_code_provider.dart';

class PhoneNumberInput extends ConsumerWidget {
  final TextEditingController phoneController;

  const PhoneNumberInput({
    super.key,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendCodeViewModelProvider);
    final notifier = ref.read(sendCodeViewModelProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppStrings.sendCodePhoneNumber,
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
          controller: phoneController,
          onChanged: (value) => notifier.onPhoneChanged(value),
          decoration: InputDecoration(
            hintText: AppStrings.sendCodeHintText,
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
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
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
                        phoneController.clear();
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
      ],
    );
  }
}

