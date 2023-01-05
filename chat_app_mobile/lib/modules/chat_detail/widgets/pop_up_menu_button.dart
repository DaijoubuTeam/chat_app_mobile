import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpMenuItemButton extends StatelessWidget {
  const PopUpMenuItemButton({
    super.key,
    required this.label,
    required this.icon,
    required this.chatRoomId,
    this.backgroundColor,
  });

  final String chatRoomId;
  final String label;
  final IconData icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        child: Icon(
          icon,
          size: 20.sp,
          color: Colors.white,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
