import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void toastMessage(String text,BuildContext context,Color bgColor) async {
  showToast(
    text,
    context: context,
    backgroundColor: bgColor,
    duration: const Duration(seconds: 2),
    animation: StyledToastAnimation.fade,
    reverseAnimation: StyledToastAnimation.fade
  );
}
