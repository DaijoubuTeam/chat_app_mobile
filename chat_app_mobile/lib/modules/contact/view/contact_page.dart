import 'package:chat_app_mobile/common/widgets/stateless/app_bar/home_app_bar.dart';
import 'package:chat_app_mobile/modules/friends/view/friend_list.dart';
import 'package:chat_app_mobile/modules/group_list/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Friends', 'Groups'];
    final List<Tab> tabs = <Tab>[
      const Tab(
        child: FriendsListPage(),
      ),
      const Tab(
        child: GroupListPage(),
      ),
    ];
    return Scaffold(
      body: Center(
        child: DefaultTabController(
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
                appBar: HomeAppBarCustom(
                  bottomWidget: TabBar(
                    tabs: List<Widget>.generate(categories.length, (index) {
                      return Tab(
                        text: categories[index],
                      );
                    }),
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelColor: Colors.grey,
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
      ),
    );
  }
}
