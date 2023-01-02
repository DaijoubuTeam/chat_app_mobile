import 'dart:ui';

import 'package:chat_app_mobile/common/widgets/stateless/group_list_view/chat_group_list_view.dart';
import 'package:chat_app_mobile/modules/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button_go_to_new_message.dart';

class ChatContents extends StatefulWidget {
  const ChatContents({
    super.key,
    required this.messageId,
  });

  final String? messageId;

  @override
  State<ChatContents> createState() => _ChatContentsState();
}

class _ChatContentsState extends State<ChatContents> {
  late ScrollController controller;
  late double controllerOffset = 1.0;

  @override
  void initState() {
    super.initState();
    //init scroll controller and controller offset
    if (widget.messageId != null) {
      controller = ScrollController(
        keepScrollOffset: true,
        initialScrollOffset: 1,
      );
      controllerOffset = 1.0;
    } else {
      controller = ScrollController(
        keepScrollOffset: true,
        initialScrollOffset: 0,
      );
      controllerOffset = 0.0;
    }

    controller.addListener(
      () {
        setState(() {
          controllerOffset = controller.offset;
        });

        if (controller.position.maxScrollExtent == controller.offset) {
          if (mounted) {
            context.read<ChatDetailBloc>().add(ChatDetailListMessageTopLoad());
          }
        }
        // if (controller.position.pixels == 0 || widget.messageId != null) {
        //   if (mounted) {
        //     context.read<ChatDetailBloc>().add(ChatDetailListMessageLoadMore());
        //   }
        // }
      },
    );
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
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final listMessage = state.listMessage ?? [];
        return Container(
          //color: Colors.white,
          decoration: BoxDecoration(
            image: state.chatRoomInfo?.chatRoomAvatar != null
                ? DecorationImage(
                    image: NetworkImage(state.chatRoomInfo!.chatRoomAvatar!),
                    fit: BoxFit.contain,
                  )
                : null,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10000, sigmaY: 10000),
            child: Container(
              color: Colors.black.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
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
