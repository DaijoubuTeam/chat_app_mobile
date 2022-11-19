import 'package:chat_app_mobile/modules/group_create/view/group_create_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../group_request/view/view.dart';

class ButtonCreateGroup extends StatelessWidget {
  const ButtonCreateGroup({super.key});

  void _handleTapListTileGroupRequest(BuildContext ctx) {
    ctx.pushNamed(GroupCreatePage.namePage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.group_add_outlined,
            color: Colors.white,
          ),
        ),
        title: const Text('Create new group'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _handleTapListTileGroupRequest(context),
      ),
    );
  }
}
