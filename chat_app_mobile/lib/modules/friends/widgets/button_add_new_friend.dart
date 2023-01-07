import 'package:chat_app_mobile/modules/friends/bloc/friends_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../find_friend/view/view.dart';
import '../../friend_profile/view/friend_profile_page.dart';

class ButtonAddNewFriend extends StatelessWidget {
  const ButtonAddNewFriend({super.key});

  void _buildModalBottomSheet(BuildContext ctx) async {
    await Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (ctx) => const FindFriendPage()))
        .then(
      (value) async {
        final isFindFriend = value["isFindFriend"] as bool;

        if (!isFindFriend) {
          return;
        } else {
          final uid = value["uid"] as String;
          await Navigator.of(ctx)
              .push(MaterialPageRoute(
                  builder: (ctx) => FriendProfilePage(friendId: uid)))
              .then((_) => {
                    ctx.read<FriendsBloc>().add(const FriendsInited()),
                  });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.person_add_outlined,
            color: Colors.white,
          ),
        ),
        title: const Text('Add new friend'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _buildModalBottomSheet(context),
      ),
    );
  }
}
