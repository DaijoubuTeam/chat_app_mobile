import 'package:chat_app_mobile/common/widgets/stateless/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomsSkeleton extends StatelessWidget {
  const ChatRoomsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Skeleton.circle(
              width: 36.w,
              height: 36.h,
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Skeleton.rectangular(
                height: 20.h,
                width: 100.w,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Skeleton.rectangular(
                  height: 20.h,
                  width: 200.w,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }
}
