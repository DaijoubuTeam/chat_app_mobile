import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:chat_app_mobile/modules/group_request_sent/view/view.dart';
import 'package:flutter/material.dart';

import '../../group_request_receive/view/view.dart';

class GroupRequestPage extends StatelessWidget {
  const GroupRequestPage({Key? key}) : super(key: key);

  static String namePage = 'GroupRequestPage';

  @override
  Widget build(BuildContext context) {
    return const GroupRequestView();
  }
}

class GroupRequestView extends StatelessWidget {
  const GroupRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Receive', 'Send'];
    final List<Tab> tabs = <Tab>[
      const Tab(
        child: GroupRequestReceivePage(),
      ),
      const Tab(
        child: GroupRequestSentPage(),
      ),
    ];

    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(
              () {
                if (!tabController.indexIsChanging) {
                  // Your code goes here.
                  // To get index of current tab use tabController.index
                }
              },
            );
            return Scaffold(
              appBar: AppBarCustom(
                title: "Group Request",
                bottomWidget: TabBar(
                  tabs: List<Widget>.generate(categories.length, (index) {
                    return Tab(
                      text: categories[index],
                    );
                  }),
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              body: TabBarView(
                children: tabs.map((Tab tab) {
                  return tab.child ??
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
