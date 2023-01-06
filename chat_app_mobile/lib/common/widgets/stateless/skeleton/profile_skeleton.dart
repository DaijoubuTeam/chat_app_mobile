import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'skeleton.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Skeleton.circle(
              width: 120.w,
              height: 120.h,
            ),
            SizedBox(
              height: 32.h,
            ),
            Skeleton.rectangular(
              height: 48.h,
              width: 360.w,
            ),
            SizedBox(
              height: 16.h,
            ),
            Skeleton.rectangular(
              height: 48.h,
              width: 360.w,
            ),
            SizedBox(
              height: 16.h,
            ),
            Skeleton.rectangular(
              height: 48.h,
              width: 360.w,
            ),
            SizedBox(
              height: 16.h,
            ),
            Skeleton.rectangular(
              height: 48.h,
              width: 360.w,
            ),
            SizedBox(
              height: 16.h,
            ),
            Skeleton.rectangular(
              height: 48.h,
              width: 360.w,
            ),
            SizedBox(
              height: 16.h,
            ),
            Skeleton.rectangular(
              height: 48.h,
              width: 360.w,
            ),
            SizedBox(
              height: 16.h,
            ),
            Skeleton.rectangular(
              height: 48.h,
              width: 360.w,
            ),
          ],
        ),
      ),
      // child: ListTile(
      //   leading: Skeleton.circle(
      //     width: 36.w,
      //     height: 36.h,
      //   ),
      //   title: Align(
      //     alignment: Alignment.centerLeft,
      //     child: Skeleton.rectangular(
      //       height: 20.h,
      //       width: 100.w,
      //     ),
      //   ),
      //   subtitle: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 16.0),
      //     child: Align(
      //       alignment: Alignment.centerLeft,
      //       child: Skeleton.rectangular(
      //         height: 20.h,
      //         width: 200.w,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
