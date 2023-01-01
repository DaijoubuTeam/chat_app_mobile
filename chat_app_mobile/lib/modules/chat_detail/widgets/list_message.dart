import 'dart:ui';

import 'package:chat_app_mobile/common/widgets/stateless/group_list_view/chat_group_list_view.dart';
import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button_go_to_new_message.dart';

class ChatContents extends StatefulWidget {
  const ChatContents({super.key});

  @override
  State<ChatContents> createState() => _ChatContentsState();
}

class _ChatContentsState extends State<ChatContents> {
  ScrollController controller = ScrollController(keepScrollOffset: true);
  double controllerOffset = 0.0;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        controllerOffset = controller.offset;
      });
      if (controller.position.maxScrollExtent == controller.offset) {
        if (mounted) {
          context.read<ChatDetailBloc>().add(ChatDetailListMessageLoadMore());
        }
      }
    });
  }

  void _scrollDown() {
    controller.animateTo(
      controller.position.minScrollExtent,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatDetailBloc, ChatDetailState>(
      // buildWhen: (previous, current) =>
      //     previous.listMessage.length != current.listMessage.length,
      builder: (context, state) {
        final listMessage = state.displayListMessage ?? [];
        return Container(
          //color: Colors.white,
          decoration: BoxDecoration(
            image: state.chatRoomInfo?.chatRoomAvatar != null
                ? DecorationImage(
                    image: NetworkImage(state.chatRoomInfo!.chatRoomAvatar!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10000, sigmaY: 10000),
            child: Container(
              color: Colors.black.withOpacity(0.01),
              child: Stack(
                children: [
                  Scrollbar(
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: GroupListViewCustom(
                        controller: controller,
                        datas: listMessage,
                      ),
                    ),
                  ),
                  if (controllerOffset != 0.0)
                    Positioned(
                      right: 0,
                      bottom: 8.h,
                      child: ButtonGoToLastestMessage(
                        handleBackToBottom: _scrollDown,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
