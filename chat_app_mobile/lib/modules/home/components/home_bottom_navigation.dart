import 'package:chat_app_mobile/modules/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
    this.tabIndex = 0,
    required this.items,
  });

  final int tabIndex;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: tabIndex,
      onTap: (value) =>
          context.read<HomeBloc>().add(SelectTabIndexChanged(value)),
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[110],
      items: items,
    );
  }
}
