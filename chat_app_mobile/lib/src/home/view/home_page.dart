import 'package:chat_app_mobile/src/call/view/view.dart';
import 'package:chat_app_mobile/src/chat/view/chat_page.dart';
import 'package:chat_app_mobile/src/home/bloc/home_bloc.dart';
import 'package:chat_app_mobile/src/setting/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    ChatPage(),
    CallPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        return Scaffold(
          body: _widgetOptions.elementAt(state.tabIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.tabIndex,
            onTap: (value) =>
                context.read<HomeBloc>().add(SelectTabIndexChanged(value)),
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
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey[250],
          ),
        );
      },
    );
  }
}
