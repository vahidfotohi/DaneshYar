import 'package:flutter/cupertino.dart';

void unfocusEditors(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
  FocusScope.of(context).unfocus();
}
