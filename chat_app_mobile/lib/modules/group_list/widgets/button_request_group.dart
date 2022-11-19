import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../group_request/view/view.dart';

class ButtonRequestGroup extends StatelessWidget {
  const ButtonRequestGroup({super.key});

  void _handleTapListTileGroupRequest(BuildContext ctx) {
    ctx.pushNamed(GroupRequestPage.namePage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.group_outlined,
            color: Colors.white,
          ),
        ),
        title: const Text('Groups Request'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _handleTapListTileGroupRequest(context),
      ),
    );
  }
}
