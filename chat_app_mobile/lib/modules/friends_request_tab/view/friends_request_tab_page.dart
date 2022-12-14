import 'package:chat_app_mobile/common/widgets/stateless/app_bar/app_bar_title.dart';
import 'package:flutter/material.dart';

import '../../friends_request/view/friends_request.dart';
import '../../friends_request_sent/view/view.dart';

class FriendRequestTabPage extends StatelessWidget {
  const FriendRequestTabPage({Key? key}) : super(key: key);

  static String namePage = 'FriendRequestTabPage';

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
        child: FriendsRequestPage(),
      ),
      const Tab(
        child: FriendsRequestSentPage(),
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
                title: "Friends Request",
                bottomWidget: TabBar(
                  tabs: List<Widget>.generate(categories.length, (index) {
                    return Tab(
                      text: categories[index],
                    );
                  }),
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
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
