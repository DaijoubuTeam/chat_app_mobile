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
        child: ListTile(
          leading: CircleAvatar(
            radius: 24,
            child: ClipOval(child: Image.network(avatar ?? '')),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(fullname ?? ''),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(email ?? ''),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                color: Theme.of(context).primaryColor,
                onPressed: () => _handleActionCard(context, uid, "accept"),
                icon: const Icon(Icons.check),
              ),
              IconButton(
                color: Theme.of(context).errorColor,
                onPressed: () => _handleActionCard(context, uid, "denied"),
                icon: const Icon(Icons.close),
              )
            ],
          ),
        ),
      ),
    );
  }
}
