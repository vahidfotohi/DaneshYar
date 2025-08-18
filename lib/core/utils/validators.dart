class AppValidators {

  static String digitsOnly(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "شماره موبایل نمی‌تواند خالی باشد.";
    }

    final trimmedValue = value.trim();
    final cleaned = digitsOnly(trimmedValue);

    if (!cleaned.startsWith('09')) {
      return "شماره موبایل باید با 09 شروع شود.";
    }

    if (cleaned.length != 11) {
      return "شماره موبایل باید 11 رقم باشد.";
    }


    // if (int.tryParse(trimmedValue) == null) {
    //   return "لطفا فقط عدد وارد کنید.";
    // }

    return null;
  }

  static String? validateOtpCode(String? value, {int length = 6}) {

    if (value == null || value.trim().isEmpty) {
      return "کد تایید باید کامل باشد.";
    }

    final trimmedValue = value.trim();
    final cleaned = digitsOnly(trimmedValue);

    if (cleaned.length != length) {
      return "کد تایید باید $length رقم باشد.";
    }

    // if (int.tryParse(trimmedValue) == null) {
    //   return "کد تایید فقط می‌تواند شامل عدد باشد.";
    // }

    return null;
  }

// می‌توانید validator های دیگری مانند validateEmail, validatePassword و ... را نیز به همین شکل اضافه کنید.
}