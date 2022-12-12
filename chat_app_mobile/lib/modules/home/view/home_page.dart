import 'package:chat_app_mobile/modules/chat/view/chat_page.dart';
import 'package:chat_app_mobile/modules/contact/view/contact_page.dart';
import 'package:chat_app_mobile/modules/home/bloc/home_bloc.dart';
import 'package:chat_app_mobile/modules/home/widgets/home_bottom_navigation.dart';
import 'package:chat_app_mobile/modules/setting/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/select_notification_stream.dart';
import '../../notifications/view/notifications_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String namePage = 'home-pages';

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

  List<BottomNavigationBarItem> _buildTabLabel() {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'Chat',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.phone),
        label: 'Contact',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Setting',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SelectNotificationStream.selectNotificationStream.stream.listen((event) {
      print("event: $event");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NotificationsPage()));
    });

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        return Scaffold(
          body: _widgetOptions.elementAt(state.tabIndex),
          bottomNavigationBar: HomeBottomNavigationBar(
            tabIndex: state.tabIndex,
            items: _buildTabLabel(),
          ),
        );
      },
    );
  }
}
