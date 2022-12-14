import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../common/widgets/stateless/dialog/custom_alert_dialog.dart';
import '../../../common/widgets/stateless/list_title/person_list_item.dart';
import '../bloc/group_member_bloc.dart';

class GroupMemberList extends StatelessWidget {
  const GroupMemberList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupMemberBloc, GroupMemberState>(
      builder: (context, state) {
        final membersInGroup = state.displayMembers;
        if (membersInGroup!.isEmpty) {
          return const Center(
            child: Text(
              "No search found",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            final bool isAdminGroup = membersInGroup[index].isAdmin ?? false;

            return PersonListItem(
              title: membersInGroup[index].fullname,
              subTitle: membersInGroup[index].email,
              avatar: membersInGroup[index].avatar,
              isAdmin: isAdminGroup,
              handleOnTab: () {},
              endActionPane: state.isAdmin && !isAdminGroup
                  ? _buildEndActionPane(
                      context,
                      membersInGroup[index].uid,
                    )
                  : null,
            );
          },
          itemCount: state.displayMembers?.length ?? 0,
        );
      },
    );
  }

  ActionPane _buildEndActionPane(BuildContext ctx, String? memberId) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (_) =>
              {if (memberId != null) handleDeleteMember(ctx, memberId)},
          backgroundColor: Colors.red[400]!,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    );
  }

  void handleDeleteMember(BuildContext ctx, String memberId) {
    var dialog = CustomAlertDialog(
        title: "Delete member",
        message: "Are you sure, do you want to delete him/her?",
        onPostivePressed: () {
          ctx.read<GroupMemberBloc>().add(
                GroupMemberDeleteSubmitted(
                  idMember: memberId,
                ),
              );
        },
        positiveBtnText: 'Yes',
        negativeBtnText: 'Cancel');
    showDialog(context: ctx, builder: (BuildContext context) => dialog);
  }
}
