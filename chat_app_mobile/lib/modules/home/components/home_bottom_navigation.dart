import 'package:chat_app_mobile/modules/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key, this.tabIndex = 0});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: tabIndex,
      onTap: (value) =>
          context.read<HomeBloc>().add(SelectTabIndexChanged(value)),
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[250],
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.phone),
          label: 'Call',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Setting',
        ),
      ],
    );
  }
}
