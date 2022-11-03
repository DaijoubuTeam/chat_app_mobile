// import 'package:chat_room_repository/chat_room_repository.dart';
// import 'package:flutter/material.dart';

// import 'chat_items.dart';

// class ListChatRoom extends StatefulWidget {
//   const ListChatRoom({super.key, required this.listChatRoom});
//   final List<ChatRoom> listChatRoom;

//   @override
//   State<ListChatRoom> createState() => _ListChatRoomState();
// }

// class _ListChatRoomState extends State<ListChatRoom> {
//   ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {},
//       child: ListView.builder(
//         shrinkWrap: true,
//         controller: _scrollController,
//         itemBuilder: ((context, index) {
//           return ChatItems(
//             // chatRoomId: listChatRoom[index].chatRoomId,
//             // chatRoomName: listChatRoom[index].chatRoomName,
//             // chatRoomAvatar: listChatRoom[index].chatRoomAvatar,
//             chatRoomId: '123',
//             chatRoomName: '123',
//             chatRoomAvatar: '123',
//           );
//         }),
//         itemCount: 50,
//       ),
//     );
//   }
// }
