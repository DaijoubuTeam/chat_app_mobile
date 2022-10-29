import 'package:flutter/material.dart';

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
                onPressed: () {},
                icon: const Icon(Icons.check),
              ),
              IconButton(
                color: Theme.of(context).errorColor,
                onPressed: () {},
                icon: const Icon(Icons.close),
              )
            ],
          ),
        ),
      ),
    );
  }
}
