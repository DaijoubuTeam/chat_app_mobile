import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/stateless/buttons/elevated_button.dart';
import '../bloc/friend_profile_bloc.dart';

class AddFriendButton extends StatelessWidget {
  const AddFriendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w,
      child: ElevatedButtonCustom(
        onPressed: () {
          context.read<FriendProfileBloc>().add(FriendProfileButtonSubmitted());
        },
        text: 'Add Friend',
      ),
    );
  }
}
