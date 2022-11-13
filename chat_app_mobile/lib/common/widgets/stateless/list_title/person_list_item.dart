import 'package:flutter/material.dart';

class PersonListItem extends StatelessWidget {
  const PersonListItem({
    super.key,
    this.avatar,
    this.isOnline = false,
    this.title,
    this.subTitle,
    this.isShowPoint = false,
    required this.handleOnTab,
  });

  final String? avatar;
  final bool isOnline;
  final String? title;
  final String? subTitle;
  final bool? isShowPoint;
  final void Function() handleOnTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey[200]!,
          ),
        ),
      ),
      child: ListTile(
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
                    backgroundImage:
                        AssetImage('assets/images/empty_avatar.png'),
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
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const Text('14:01'),
              const SizedBox(
                height: 8,
              ),
              if (isShowPoint == true)
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  // child: const Center(
                  //   child: Text(
                  //     "3",
                  //     style: TextStyle(
                  //       fontSize: 8,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
