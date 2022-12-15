import 'package:chat_app_mobile/modules/group_create/bloc/group_create_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:friend_repository/friend_repository.dart' as friend_repo;

class SearchListFriend extends StatefulWidget {
  const SearchListFriend({Key? key}) : super(key: key);

  @override
  State<SearchListFriend> createState() => _SearchListFriendState();
}

class _SearchListFriendState extends State<SearchListFriend> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _inputController.addListener(() {
      context
          .read<GroupCreateBloc>()
          .add(GroupCreateInputChanged(value: _inputController.text));
    });

    return BlocBuilder<GroupCreateBloc, GroupCreateState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search your friends",
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: (state.listFriendDisplay != null &&
                      state.listFriendDisplay!.isNotEmpty)
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(
                              state.listFriendDisplay?[index].fullname ?? ''),
                          subtitle:
                              Text(state.listFriendDisplay?[index].email ?? ''),
                          secondary: state.listFriendDisplay![index].avatar !=
                                  null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      state.listFriendDisplay![index].avatar!),
                                )
                              : const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/empty_avatar.png'),
                                  maxRadius: 24,
                                ),
                          value: state.memberNewGroup!
                              .contains(state.listFriendDisplay?[index]),
                          onChanged: (value) {
                            context.read<GroupCreateBloc>().add(
                                GroupCreateMemberChanged(
                                    user: state.listFriendDisplay![index]));
                          },
                        );
                      },
                      itemCount: state.listFriendDisplay?.length,
                    )
                  : const Text(
                      "No search found",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
