import 'package:flutter/material.dart';

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({super.key});

  static const String namePage = 'friend-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Profile Page'),
      ),
      body: const FriendProfileView(),
    );
  }
}

class FriendProfileView extends StatelessWidget {
  const FriendProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile'),
    );
  }
}
