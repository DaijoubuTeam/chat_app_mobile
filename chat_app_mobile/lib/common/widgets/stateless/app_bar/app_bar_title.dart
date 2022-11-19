import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
    this.title,
    this.bottomWidget,
  });

  final String? title;
  final PreferredSizeWidget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ''),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize {
    if (bottomWidget != null) {
      return const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
    } else {
      return const Size.fromHeight(kToolbarHeight);
    }
  }
}
