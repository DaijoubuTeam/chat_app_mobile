import 'package:chat_app_mobile/utils/date_time_local_string.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:message_repository/message_repository.dart';

import '../../../../modules/chat_detail/widgets/message_item.dart';

class GroupListViewCustom extends StatelessWidget {
  const GroupListViewCustom({
    super.key,
    required this.controller,
    required this.datas,
  });

  final ScrollController controller;
  final List<Message> datas;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<dynamic, String>(
      controller: controller,
      elements: datas,
      groupBy: (element) => DateTimeLocalString.convertToDayMonthYear(
          (element as Message).createdAt!),
      groupSeparatorBuilder: (String groupValue) =>
          _buildGroupSeperatorBuilder(groupValue),
      itemBuilder: (context, dynamic element) => _buildItemBuilder(element),
      // itemComparator: (item1, item2) =>
      //     item1['name'].compareTo(item2['name']), // optional
      //floatingHeader: true,
      useStickyGroupSeparators: true,
      stickyHeaderBackgroundColor: Colors.white,
      floatingHeader: true,
      reverse: true,
      sort: false,
      // floatingHeader: true, // optional
      // order: GroupedListOrder.ASC, // optional
    );
  }

  Widget _buildGroupSeperatorBuilder(String groupValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(groupValue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemBuilder(Message element) {
    final Message message = element;
    return MessageItem(
      key: GlobalObjectKey(element.id),
      isMe: message.isMe ?? false,
      content: message.content!,
      friendAvatar: message.from?.avatar,
      readed: message.readed?.toList(),
      type: message.type,
      time: message.createdAt,
    );
  }
}