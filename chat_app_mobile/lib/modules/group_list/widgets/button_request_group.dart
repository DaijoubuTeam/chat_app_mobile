import 'package:chat_app_mobile/modules/group_list/bloc/group_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../group_request/view/view.dart';

class ButtonRequestGroup extends StatelessWidget {
  const ButtonRequestGroup({super.key});

  void _handleTapListTileGroupRequest(BuildContext ctx) {
    ctx.pushNamed(GroupRequestPage.namePage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupListBloc, GroupListState>(
      builder: (context, state) {
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (state.numberRequestRoom > 0)
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                  ),
                const Icon(Icons.chevron_right)
              ],
            ),
            onTap: () => _handleTapListTileGroupRequest(context),
          ),
        );
      },
    );
  }
}
