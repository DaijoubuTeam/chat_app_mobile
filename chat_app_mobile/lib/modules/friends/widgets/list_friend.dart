import 'package:chat_app_mobile/common/widgets/dialogs/confirm_dialog.dart';
import 'package:chat_app_mobile/common/widgets/stateless/list_title/person_list_item.dart';
import 'package:chat_app_mobile/modules/friends/bloc/friends_bloc.dart';
import 'package:chat_app_mobile/modules/friends/widgets/number_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/alert_button/accept_button.dart';
import '../../../common/widgets/alert_button/denied_button.dart';
import '../../../common/widgets/stateless/skeleton/chat_rooms_skeleton.dart';
import '../../chat_detail/view/view.dart';

class ListFriend extends StatelessWidget {
  const ListFriend({super.key});

  ActionPane _buildEndActionPane(BuildContext ctx, String friendId) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (_) => _handleDeleteFriends(ctx, friendId),
          backgroundColor: Colors.red[400]!,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete friends',
        ),
      ],
    );
  }

  void _handleDeleteFriends(BuildContext ctx, String friendId) {
    ConfirmDiaglog.showConfirmDialog(
      ctx,
      "Confirm delete friend",
      "Do you want to delete your friend?",
      [
        DeniedButton(
          handleClick: () {
            // Close the dialog
            Navigator.of(ctx).pop();
          },
        ),
        SizedBox(
          width: 16.sp,
        ),
        AcceptButton(
          handleClick: () {
            ctx.read<FriendsBloc>().add(FriendsDeleted(friendId: friendId));
            Navigator.of(ctx).pop();
          },
        ),
      ],
    );
  }

  void _handleTapFriendItem(
    BuildContext ctx,
    String? chatRoomId,
  ) {
    if (chatRoomId == null) return;
    ctx.pushNamed(
      ChatDetailPage.namePage,
      params: {'chatRoomId': chatRoomId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state.runtimeType == FriendsGetListSuccess) {
          final listFriend = (state as FriendsGetListSuccess).listFriend;
          if (listFriend.isEmpty) {
            return const Center(
              child: Text('No friends!'),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NumberFriend(
                numberFriend: listFriend.length,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return PersonListItem(
                      avatar: listFriend[index].avatar,
                      title: listFriend[index].fullname,
                      subTitle: listFriend[index].phone,
                      endActionPane: _buildEndActionPane(
                        context,
                        listFriend[index].uid,
                      ),
                      handleOnTab: () => _handleTapFriendItem(
                        context,
                        state.listFriend[index].personalChatRoomId,
                      ),
                    );
                  }),
                  itemCount: listFriend.length,
                ),
              ),
            ],
          );
        }
        if (state.runtimeType == FriendsGetListInProgress) {
          return const Center(
            child: ChatRoomsSkeleton(),
          );
        }
        return const Center(
          child: Text('Somethings wrongs'),
        );
      },
    );
  }
}
