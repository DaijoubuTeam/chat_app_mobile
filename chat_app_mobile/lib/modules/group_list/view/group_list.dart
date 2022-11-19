import 'package:chat_app_mobile/modules/group_list/widgets/button_request_group.dart';
import 'package:flutter/material.dart';

import '../widgets/button_create_group.dart';
import '../widgets/list_group_jonied.dart';

class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GroupListView();
  }
}

class GroupListView extends StatelessWidget {
  const GroupListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const ButtonRequestGroup(),
          const ButtonCreateGroup(),
          Divider(
            height: 25,
            color: Theme.of(context).backgroundColor,
            thickness: 16,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: const Scrollbar(
                child: ListGroupJoined(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
