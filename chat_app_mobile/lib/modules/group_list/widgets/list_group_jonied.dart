import 'package:flutter/material.dart';

import '../../../common/widgets/stateless/list_title/person_list_item.dart';

class ListGroupJoined extends StatelessWidget {
  const ListGroupJoined({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        return PersonListItem(
          handleOnTab: () => {},
        );
      }),
      itemCount: 50,
    );
  }
}
