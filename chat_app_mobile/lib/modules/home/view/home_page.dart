import 'package:chat_app_mobile/modules/chat/view/chat_page.dart';
import 'package:chat_app_mobile/modules/contact/view/contact_page.dart';
import 'package:chat_app_mobile/modules/home/bloc/home_bloc.dart';
import 'package:chat_app_mobile/modules/home/components/home_bottom_navigation.dart';
import 'package:chat_app_mobile/modules/setting/view/view.dart';
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
          bottomNavigationBar: HomeBottomNavigationBar(
            tabIndex: state.tabIndex,
          ),
        );
      },
    );
  }
}
