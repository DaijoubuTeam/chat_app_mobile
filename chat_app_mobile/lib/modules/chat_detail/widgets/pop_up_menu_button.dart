import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpMenuItemButton extends StatelessWidget {
  const PopUpMenuItemButton({
    super.key,
    required this.label,
    required this.icon,
    required this.chatRoomId,
  });

  final String chatRoomId;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20.sp,
        color: Colors.black,
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
