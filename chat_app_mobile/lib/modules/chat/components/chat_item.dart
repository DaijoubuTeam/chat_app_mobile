import 'package:chat_app_mobile/modules/chat_detail/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.chatRoomId,
    this.chatRoomName,
    this.chatRoomAvatar,
  });

  final String chatRoomId;
  final String? chatRoomName;
  final String? chatRoomAvatar;

  void _handleTabChatRoomItem(BuildContext ctx) {
    ctx.pushNamed(
      ChatDetailPage.namePage,
      params: {'chatRoomId': chatRoomId},
      extra: {
        'chatRoomName': chatRoomName,
        'chatRoomAvatar': chatRoomAvatar,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _handleTabChatRoomItem(context),
      minVerticalPadding: 20,
      leading: Stack(
        children: [
          (chatRoomAvatar != null)
              ? CircleAvatar(
                  backgroundImage: NetworkImage(chatRoomAvatar!),
                  maxRadius: 24,
                )
              : CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  maxRadius: 24,
                ),
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
        chatRoomName ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
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
              height: 6,
            ),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
