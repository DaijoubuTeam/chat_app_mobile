import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/modules/group_edit/bloc/group_edit_bloc.dart';
import 'package:chat_app_mobile/modules/group_edit/widgets/edit_evatar_group.dart';
import 'package:chat_app_mobile/modules/group_edit/widgets/edit_name_group.dart';
import 'package:chat_app_mobile/utils/hide_keyboard.dart';
import 'package:chat_room_repository/chat_room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupEditPage extends StatelessWidget {
  const GroupEditPage({
    super.key,
    required this.groupId,
  });

  static const namePage = "group-edit-page";
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupEditBloc(
          authRepository: context.read<AuthRepository>(),
          chatRoomRepository: context.read<ChatRoomRepository>(),
          groupId: groupId),
      child: const GroupEditView(),
    );
  }
}

class GroupEditView extends StatelessWidget {
  const GroupEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupEditBloc, GroupEditState>(
      builder: (context, state) {
        if (state is GroupEditGetInforSuccess) {
          return Scaffold(
            appBar: const AppBarCustom(
              title: "Edit group",
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: GestureDetector(
              onTap: () => SettingsKeyboard.hideKeyBoard(context),
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const EditAvatarGroup(),
                            SizedBox(
                              height: 32.h,
                            ),
                            const EditNameGroup(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<GroupEditBloc>().add(const GroupEditSubmitted());
                SettingsKeyboard.hideKeyBoard(context);
              },
              child: const Icon(Icons.check),
            ),
          );
        }
        return const Scaffold(
          appBar: AppBarCustom(
            title: "Edit group",
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
