import 'package:chat_app_mobile/modules/group_add_new_member/bloc/group_add_new_member_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNewMember extends StatelessWidget {
  const ListNewMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupAddNewMemberBloc, GroupAddNewMemberState>(
      builder: (context, state) {
        if (state.newMemberGroup != null && state.newMemberGroup!.isNotEmpty) {
          return SizedBox(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // const Text(
                //   "Member group",
                //   style: TextStyle(
                //     fontWeight: FontWeight.w600,
                //     fontSize: 20,
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: state.newMemberGroup![index].avatar != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    state.newMemberGroup![index].avatar!),
                              )
                            : const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/empty_avatar.png'),
                                maxRadius: 24,
                              ),
                      );
                    },
                    itemCount: state.newMemberGroup!.length,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text("No members in your new groups");
        }
      },
    );
  }
}
