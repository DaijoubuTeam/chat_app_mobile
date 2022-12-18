import 'package:chat_app_mobile/modules/friends/bloc/friends_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../friends_request_tab/view/friends_request_tab_page.dart';

class ButtonRequestFriend extends StatelessWidget {
  const ButtonRequestFriend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
            ),
            title: const Text('Friends Request'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (state is FriendsGetListSuccess &&
                    state.numberRequestFriend > 0)
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
            onTap: () {
              context.pushNamed(FriendRequestTabPage.namePage);
            },
          ),
        );
      },
    );
  }
}
