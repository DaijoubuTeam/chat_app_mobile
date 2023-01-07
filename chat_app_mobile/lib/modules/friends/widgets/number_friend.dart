import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberFriend extends StatelessWidget {
  const NumberFriend({
    super.key,
    this.numberFriend = 0,
  });

  final int numberFriend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Text(
        "Friends ($numberFriend)",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
