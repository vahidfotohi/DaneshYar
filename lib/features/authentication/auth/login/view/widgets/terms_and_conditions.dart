import 'package:daneshyar/core/constants/strings.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
          children: [
            const TextSpan(text: AppStrings.sendCodeTerm),
            TextSpan(
              text: AppStrings.sendCodeTermMiddle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryFixed,
              ),
            ),
            const TextSpan(text: AppStrings.sendCodeTermLast),
          ],
        ),
      ),
    );
  }
}
