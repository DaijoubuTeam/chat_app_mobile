import 'package:chat_app_mobile/common/widgets/stateless/list_title/request_friend_list_item.dart';
import 'package:chat_app_mobile/modules/friends_request/bloc/friends_request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemUserRequest extends StatelessWidget {
  const ItemUserRequest(
      {super.key,
      required this.uid,
      this.gender,
      this.fullname,
      this.avatar,
      this.phone,
      this.about,
      this.email});

  final String uid;
  final String? gender;
  final String? fullname;
  final String? avatar;
  final String? phone;
  final String? about;
  final String? email;

  void _handleActionCard(BuildContext ctx, String id, String action) {
    ctx
        .read<FriendsRequestBloc>()
        .add(FriendRequestCardAction(id: id, action: action));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: RequestFriendListItem(
          avatar: avatar,
          title: fullname,
          subtitle: email,
          acceptAction: () => _handleActionCard(context, uid, "accept"),
          denyAction: () => _handleActionCard(context, uid, "denied"),
        ),
      ),
    );
  }
}
