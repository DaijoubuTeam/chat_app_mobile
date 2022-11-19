import 'package:chat_app_mobile/modules/notifications/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarCustom({
    super.key,
    this.bottomWidget,
    this.numberNotification = 0,
  });

  final PreferredSizeWidget? bottomWidget;
  final int numberNotification;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
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
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            showSearch(context: context, delegate: CustomSearch());
          },
        ),
        IconButton(
          icon: Stack(
            children: [
              Icon(
                Icons.notifications,
                color: Theme.of(context).primaryColor,
              ),
              if (numberNotification > 0)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                )
            ],
          ),
          onPressed: () {
            context.pushNamed(NotificationsPage.namePage);
          },
        ),
      ],
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize {
    if (bottomWidget != null) {
      return const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
    } else {
      return const Size.fromHeight(kToolbarHeight);
    }
  }
}

class CustomSearch extends SearchDelegate {
  // data lay tu api
  List<String> allData = ['American', 'Russia', 'VietNam', 'China', 'Italy'];
  List<String> res = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.done,
            color: res.isEmpty ? Colors.grey : Colors.blue,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text('text'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        return RadioListTile<String>(
          groupValue: null,
          value: allData[index],
          onChanged: (value) {
            if (res.contains(value)) {
              res.remove(value);
            } else {
              res.add(value!);
            }
            print(res);
          },
          toggleable: true,
          title: Text(allData[index]),
        );
      }),
      itemCount: allData.length,
    );
  }
}
