import 'package:flutter/material.dart';

class RequestFriendListItem extends StatelessWidget {
  const RequestFriendListItem({
    super.key,
    this.avatar,
    this.title,
    this.subtitle,
    this.subtitleTextSpan,
    this.acceptAction,
    this.denyAction,
    this.customActionButton,
  });
  final String? avatar;
  final String? title;
  final String? subtitle;
  final Widget? subtitleTextSpan;
  final void Function()? acceptAction;
  final void Function()? denyAction;
  final Widget? customActionButton;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: avatar != null
          ? CircleAvatar(radius: 24, backgroundImage: NetworkImage(avatar!))
          : const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/empty_avatar.png'),
            ),
      title: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Text(title ?? ''),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: subtitle != null
            ? Text(
                subtitle ?? '',
                maxLines: 5,
                softWrap: true,
              )
            : subtitleTextSpan,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (acceptAction != null)
            IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: acceptAction,
              icon: const Icon(Icons.check),
            ),
          if (denyAction != null)
            IconButton(
              color: Theme.of(context).errorColor,
              onPressed: denyAction,
              icon: const Icon(Icons.close),
            ),
          if (customActionButton != null) customActionButton!,
        ],
      ),
    );
  }
}
