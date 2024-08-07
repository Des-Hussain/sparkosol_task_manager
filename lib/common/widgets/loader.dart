import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowLoader {
  static bool isOpen = false;
  static showLoading(
    BuildContext context,
    // bool dismisss,
  ) {
    isOpen = true;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          isOpen = true;
          return Container(
            width: 130,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            height: 130,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(
                  radius: 30,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }).then((value) {
      isOpen = false;
    });
  }

  static hideLoading(BuildContext context) {
    if (isOpen) {
      Navigator.of(context).pop();
    }
  }
}
