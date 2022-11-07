import 'package:flutter/material.dart';

class PersonListItem extends StatelessWidget {
  const PersonListItem({
    super.key,
    this.avatar,
    this.isOnline = false,
    this.title,
    this.subTitle,
    required this.handleOnTab,
  });

  final String? avatar;
  final bool isOnline;
  final String? title;
  final String? subTitle;
  final void Function() handleOnTab;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: handleOnTab,
      minVerticalPadding: 20,
      leading: Stack(
        children: [
          (avatar != null)
              ? CircleAvatar(
                  backgroundImage: NetworkImage(avatar!),
                  maxRadius: 24,
                )
              : const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/empty_avatar.png'),
                  maxRadius: 24,
                ),
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
              ),
            )
        ],
      ),
      title: Text(
        title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          subTitle ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
    ;
  }
}
