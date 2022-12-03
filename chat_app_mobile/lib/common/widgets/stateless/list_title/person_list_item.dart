import 'package:chat_app_mobile/common/widgets/stateless/avatars/circle_avatar_network.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class PersonListItem extends StatelessWidget {
  const PersonListItem({
    super.key,
    this.avatar,
    this.isOnline = false,
    this.title,
    this.subTitle,
    this.isShowPoint = false,
    this.time,
    required this.handleOnTab,
    this.startActionPane,
    this.endActionPane,
  });

  final String? avatar;
  final bool isOnline;
  final String? title;
  final String? subTitle;
  final DateTime? time;
  final bool? isShowPoint;
  final void Function() handleOnTab;
  final ActionPane? startActionPane;
  final ActionPane? endActionPane;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // The start action pane is the one at the left or the top side.

      // The end action pane is the one at the right or the bottom side.
      startActionPane: startActionPane,
      endActionPane: endActionPane,
      child: Container(
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
              CircleAvatarCustom(
                urlImage: avatar,
                widthImage: 48,
                heightImage: 48,
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
                if (time != null) Text(DateFormat.jm().format(time!.toLocal())),
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
      ),
    );
  }
}
