import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/modules/group_create/bloc/group_create_bloc.dart';
import 'package:chat_app_mobile/modules/group_create/widgets/search_list_friend.dart';
import 'package:chat_app_mobile/modules/group_create/widgets/text_field_name_group.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:friend_repository/friend_repository.dart';

import '../widgets/list_member_group.dart';
import '../widgets/upload_image_group_button.dart';

class GroupCreatePage extends StatelessWidget {
  const GroupCreatePage({Key? key}) : super(key: key);

  static const namePage = 'groupCreatePage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupCreateBloc(
        context.read<AuthRepository>(),
        context.read<FriendRepository>(),
        context.read<ChatRoomRepository>(),
      ),
      child: const GroupCreateView(),
    );
  }
}

class GroupCreateView extends StatelessWidget {
  const GroupCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupCreateBloc, GroupCreateState>(
      listenWhen: (prev, current) => prev.status != current.status,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess &&
            state.groupName != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Create group chat success"),
                backgroundColor: Colors.green,
              ),
            );
        }
        if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Create group chat failure"),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create new group"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context
                    .read<GroupCreateBloc>()
                    .add(const GroupCreateFormSubmitted());
              },
              child: const Text("Done"),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    UploadImageGroupButton(),
                    SizedBox(
                      width: 32,
                    ),
                    Expanded(
                      child: TextFieldNameGroup(),
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const ListNewMemberGroup(),
                const SizedBox(
                  height: 20,
                ),
                const Flexible(
                  fit: FlexFit.loose,
                  child: SearchListFriend(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
