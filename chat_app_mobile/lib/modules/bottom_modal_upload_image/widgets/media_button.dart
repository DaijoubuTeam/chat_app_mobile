import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MediaButton extends StatelessWidget {
  const MediaButton({
    super.key,
    this.icon,
    this.title,
    this.color,
    this.handleTap,
  });

  final Widget? icon;
  final Color? color;
  final String? title;
  final Function()? handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: 100.w,
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: icon,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(title ?? ""),
          ],
        ),
      ),
    );
    ;
  }
}
