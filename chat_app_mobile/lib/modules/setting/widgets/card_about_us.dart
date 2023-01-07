import 'package:chat_app_mobile/modules/about_us/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardAboutUs extends StatelessWidget {
  const CardAboutUs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.person_outline,
              color: Colors.black,
            )
          ],
        ),
        minLeadingWidth: 16,
        title: const Text(
          'About us',
          style: TextStyle(fontSize: 18),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          context.pushNamed(AboutUsPage.namePage);
        },
      ),
    );
  }
}
