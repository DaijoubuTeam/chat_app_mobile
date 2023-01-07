import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/modules/group_list/bloc/group_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../group_request/view/view.dart';

class ButtonRequestGroup extends StatelessWidget {
  const ButtonRequestGroup({super.key});

  void _handleTapListTileGroupRequest(BuildContext ctx) async {
    await Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (_) => const GroupRequestPage()))
        .then(
          (_) => {
            ctx.read<AppBloc>().add(AppNotificationNumberChanged()),
            ctx.read<GroupListBloc>().add(GroupListRefreshed()),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupListBloc, GroupListState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.group_outlined,
                color: Colors.white,
              ),
            ),
            title: const Text('Groups Request'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (state.numberRequestRoom > 0)
                  Container(
                    height: 14.h,
                    width: 14.w,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        state.numberRequestRoom.toString(),
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 8.w,
                ),
                if (state.numberSentRoom > 0)
                  Container(
                    height: 14.h,
                    width: 14.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        state.numberSentRoom.toString(),
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 4.w,
                ),
                const Icon(Icons.chevron_right)
              ],
            ),
            onTap: () => _handleTapListTileGroupRequest(context),
          ),
        );
      },
    );
  }
}
