import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDiaglog {
  static void showConfirmDialog(BuildContext context, String title,
      String content, List<Widget> actions) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          elevation: 10,
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowButtonSpacing: 8.sp,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Flexible(child: Text(content)),
            ],
          ),
          actions: actions,
        );
      },
    );
  }
}
