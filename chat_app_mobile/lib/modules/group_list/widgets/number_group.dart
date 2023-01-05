import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberGroup extends StatelessWidget {
  const NumberGroup({
    super.key,
    this.numberGroup = 0,
  });

  final int numberGroup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Text(
        "Groups ($numberGroup)",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
