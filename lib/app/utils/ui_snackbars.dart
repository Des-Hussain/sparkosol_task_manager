import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';



enum SnackBarType { warn, error, info, success }

class UIFeedback {
  UIFeedback._();


  static message(
      BuildContext context, {required String message,
      SnackBarType type = SnackBarType.error,
      bool? showConfirmBtn}) async {
    toastification.dismissAll();
    toastification.show(
      context: context,
      // optional if you use ToastificationWrapper
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 5),
      // you can also use RichText widget for title and description parameters
      description: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      icon: type == SnackBarType.error
          ? const Icon(Icons.cancel)
          : type == SnackBarType.warn
              ? const Icon(Icons.warning_amber_rounded)
              : type == SnackBarType.success
                  ? const Icon(Icons.check_circle_outline)
                  : const Icon(Icons.info_outline),
      primaryColor: type == SnackBarType.error
          ? Colors.red
          : type == SnackBarType.warn
              ? Colors.orange
              : type == SnackBarType.success
                  ? Colors.green
                  : Colors.blue,
      backgroundColor: Colors.white,
      // foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            toastification.dismissById(toastItem.id),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => false,
      ),
    );
  }
}
