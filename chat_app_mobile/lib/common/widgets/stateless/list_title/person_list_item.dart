import 'package:chat_app_mobile/common/widgets/stateless/avatars/circle_avatar_network.dart';
import 'package:chat_app_mobile/utils/date_time_local_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class PersonListItem extends StatelessWidget {
  const PersonListItem({
    super.key,
    this.avatar,
    this.isOnline = false,
    this.title,
    this.subTitle,
    this.nameActor,
    this.isShowPoint = false,
    this.time,
    this.isAdmin = false,
    required this.handleOnTab,
    this.startActionPane,
    this.endActionPane,
  });

  final String? avatar;
  final bool isOnline;
  final String? title;
  final String? subTitle;
  final String? nameActor;
  final DateTime? time;
  final bool isAdmin;
  final bool? isShowPoint;
  final void Function() handleOnTab;
  final ActionPane? startActionPane;
  final ActionPane? endActionPane;

  @override
  Widget build(BuildContext context) {
    return Slidable(
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
            ],
          ),
          title: Text(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: nameActor == null
                ? Text(
                    subTitle ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      maxLines: 1,
                      text: TextSpan(
                          text: "$nameActor: ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                          children: [
                            WidgetSpan(
                              child: Text(
                                ' $subTitle',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  //letterSpacing: 1,
                                  textBaseline: TextBaseline.ideographic,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                if (isAdmin)
                  Text(
                    "Admin",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                if (time != null)
                  Text(
                    DateTimeLocalString.convertToHourMinuteFollowDay(time!),
                  ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
