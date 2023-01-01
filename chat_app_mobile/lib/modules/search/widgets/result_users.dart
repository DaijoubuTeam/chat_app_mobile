import 'package:chat_app_mobile/common/widgets/stateless/list_title/person_list_item.dart';
import 'package:chat_app_mobile/modules/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultUser extends StatelessWidget {
  const ResultUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (prev, current) => prev.users != current.users,
      builder: (context, state) {
        if (state.users != null && state.users!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Your friends",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => PersonListItem(
                  avatar: state.users![index].avatar,
                  title: state.users![index].fullname,
                  handleOnTab: () {},
                ),
                itemCount: state.users!.length,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
