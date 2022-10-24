import 'package:chat_app_mobile/modules/friends/view/friend_list.dart';
import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Friends', 'Groups', 'Call'];
    final List<Tab> tabs = <Tab>[
      const Tab(
        child: FriendsListPage(),
      ),
      Tab(
        child: Container(
          child: Center(),
        ),
      ),
      Tab(
        child: Container(
          child: Center(),
        ),
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
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 16,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            'assets/images/Logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Expanded(
                        child: Text(
                          'CS Chat App',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                  bottom: TabBar(
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
                  backgroundColor: Colors.white,
                  elevation: 0,
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
