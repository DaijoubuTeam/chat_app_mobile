import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/stateless/buttons/elevated_button.dart';
import '../bloc/friend_profile_bloc.dart';

class AddFriendButton extends StatelessWidget {
  const AddFriendButton({
    Key? key,
    this.isSentRequest = false,
  }) : super(key: key);

  final bool isSentRequest;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w,
      child: ElevatedButtonCustom(
        backgroundColor: isSentRequest ? Colors.grey : null,
        onPressed: isSentRequest
            ? null
            : () {
                context
                    .read<FriendProfileBloc>()
                    .add(FriendProfileButtonSubmitted());
                Navigator.of(context).pop();
              },
        text: 'Add Friend',
      ),
    );
  }
}
