import 'package:chat_app_mobile/modules/friend_profile/bloc/friend_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendProfilePage extends StatelessWidget {
  const FriendProfilePage({super.key});

  static const String namePage = 'friend-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Profile Page'),
      ),
      body: BlocProvider(
        create: (_) => FriendProfileBloc(),
        child: const FriendProfileView(),
      ),
    );
  }
}

class FriendProfileView extends StatelessWidget {
  const FriendProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<FriendProfileBloc, FriendProfileState>(
        builder: (context, state) {
          return Text(state.email);
        },
      ),
    );
  }
}
