import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/common/widgets/stateless/list_title/person_list_item.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const String namePage = 'notifications';

  @override
  Widget build(BuildContext context) {
    return const NotificationsView();
  }
}

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Notifications"),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return PersonListItem(handleOnTab: () {});
        }),
        itemCount: 1,
      ),
    );
  }
}
