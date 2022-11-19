import 'package:chat_app_mobile/modules/group_create/bloc/group_create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNewMemberGroup extends StatelessWidget {
  const ListNewMemberGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCreateBloc, GroupCreateState>(
      builder: (context, state) {
        if (state.memberNewGroup != null && state.memberNewGroup!.isNotEmpty) {
          return Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Member group",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: state.memberNewGroup![index].avatar != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    state.memberNewGroup![index].avatar!),
                              )
                            : const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/empty_avatar.png'),
                                maxRadius: 24,
                              ),
                      );
                    },
                    itemCount: state.memberNewGroup!.length,
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
