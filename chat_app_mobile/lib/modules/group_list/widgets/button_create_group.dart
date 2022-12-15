import 'package:chat_app_mobile/modules/group_create/view/group_create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/group_list_bloc.dart';

class ButtonCreateGroup extends StatelessWidget {
  const ButtonCreateGroup({super.key});

  void _handleTapListTileGroupRequest(BuildContext ctx) async {
    await Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (ctx) => const GroupCreatePage()))
        .then((_) {
      ctx.read<GroupListBloc>().add(GroupListInited());
    });
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
