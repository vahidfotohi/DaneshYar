class AppValidators {

  AppValidators._();


  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "شماره موبایل نمی‌تواند خالی باشد.";
    }

    final trimmedValue = value.trim();

    if (!trimmedValue.startsWith('09')) {
      return "شماره موبایل باید با 09 شروع شود.";
    }

    if (trimmedValue.length != 11) {
      return "شماره موبایل باید 11 رقم باشد.";
    }


    if (int.tryParse(trimmedValue) == null) {
      return "لطفا فقط عدد وارد کنید.";
    }

    return null;
  }

  static String? validateOtpCode(String? value, {int length = 5}) {
    if (value == null || value.trim().isEmpty) {
      return "کد تایید نمی‌تواند خالی باشد.";
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length != length) {
      return "کد تایید باید $length رقم باشد.";
    }

    if (int.tryParse(trimmedValue) == null) {
      return "کد تایید نامعتبر است.";
    }

    return null;
  }

// می‌توانید validator های دیگری مانند validateEmail, validatePassword و ... را نیز به همین شکل اضافه کنید.
}