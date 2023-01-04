import 'dart:developer';

import 'package:chat_app_mobile/config/router/go_router_refresh_stream.dart';
import 'package:chat_app_mobile/config/router/transition_page.dart';
import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/modules/call_page/view/call_page.dart';
import 'package:chat_app_mobile/modules/chat_detail/view/view.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/view/view.dart';
import 'package:chat_app_mobile/modules/devices/view/device_page.dart';
import 'package:chat_app_mobile/modules/edit_profile/view/view.dart';
import 'package:chat_app_mobile/modules/fill_profile/view/view.dart';
import 'package:chat_app_mobile/modules/forgot_password/view/view.dart';
import 'package:chat_app_mobile/modules/friend_profile/view/view.dart';
import 'package:chat_app_mobile/modules/group_add_new_member/view/group_add_new_member.dart';
import 'package:chat_app_mobile/modules/group_create/view/group_create_page.dart';
import 'package:chat_app_mobile/modules/group_edit/view/view.dart';
import 'package:chat_app_mobile/modules/group_member/view/group_member_page.dart';
import 'package:chat_app_mobile/modules/home/view/view.dart';
import 'package:chat_app_mobile/modules/login/view/view.dart';
import 'package:chat_app_mobile/modules/notifications/view/view.dart';
import 'package:chat_app_mobile/modules/signup/view/view.dart';
import 'package:chat_app_mobile/modules/splash_screen/view/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_room_repository/chat_room_repository.dart'
    as chat_room_repo;

import '../../modules/friends_request_tab/view/view.dart';
import '../../modules/group_request/view/view.dart';

class AppRouter {
  AppRouter({required this.appBloc});

  final AppBloc appBloc;

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: '/splash-screen',
    routes: <GoRoute>[
      GoRoute(
        name: 'splach-screen',
        path: '/splash-screen',
        builder: (BuildContext context, GoRouterState state) {
          return const SplachScreen();
        },
      ),
      GoRoute(
        name: 'login',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        name: ForgotPasswordPage.namePage,
        path: '/forgot-password',
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordPage();
        },
      ),
      GoRoute(
        name: 'signUp',
        path: '/sign-up',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        name: VerifyEmailPage.namePage,
        path: '/verify-email',
        builder: (BuildContext context, GoRouterState state) {
          return const VerifyEmailPage();
        },
      ),
      GoRoute(
        name: HomePage.namePage,
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        name: NotificationsPage.namePage,
        path: '/notifications',
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationsPage();
        },
      ),
      GoRoute(
        name: CallPage.namePage,
        path: '/call-page',
        builder: (BuildContext context, GoRouterState state) {
          final mapStateExtra = state.extra as Map<String, dynamic>;
          return CallPage(
            friendId: mapStateExtra["friendId"]! as String,
            isReceiver: mapStateExtra["isReceiver"] as bool,
          );
        },
      ),
      GoRoute(
        name: GroupEditPage.namePage,
        path: '/group-edit/:groupId',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: GroupEditPage(
              groupId: state.params['groupId'] as String,
            ),
          );
        },
      ),
      GoRoute(
        name: ChatDetailPage.namePage,
        path: '/chatRooms/:chatRoomId',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final mapStateExtra = state.extra as Map<String, String?>?;
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: ChatDetailPage(
              chatRoomId: state.params['chatRoomId']!,
              messageId: mapStateExtra?['messageId'],
            ),
          );
        },
        routes: [
          GoRoute(
            name: ChatRoomDetailPage.namePage,
            path: 'chat-rooms-details',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: ChatRoomDetailPage(
                  chatRoomId: state.params['chatRoomId']!,
                ),
              );
            },
            routes: [
              GoRoute(
                name: GroupMemberPage.namePage,
                path: 'group-member',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  final mapStateExtra =
                      state.extra as Map<String, chat_room_repo.ChatRoom?>;
                  return buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: GroupMemberPage(
                      chatRoomInfor: (mapStateExtra["chatRoomInfor"])!,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    name: GroupAddNewMemberPage.namePage,
                    path: 'group-add-new-member',
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      final mapStateExtra = state.extra
                          as Map<String, List<chat_room_repo.User>?>;
                      return buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: GroupAddNewMemberPage(
                          chatRoomId: state.params['chatRoomId']!,
                          members: mapStateExtra["chatRoomMember"]!,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: EditProfilePage.namePage,
        path: '/edit-profile',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const EditProfilePage(),
          );
        },
      ),
      GoRoute(
        name: FillProfilePage.namePage,
        path: '/fill-profile',
        builder: (BuildContext context, GoRouterState state) {
          return const FillProfilePage();
        },
      ),
      GoRoute(
        name: FriendRequestTabPage.namePage,
        path: '/friends-request',
        builder: (BuildContext context, GoRouterState state) {
          return const FriendRequestTabPage();
        },
      ),
      GoRoute(
        name: FriendProfilePage.namePage,
        path: '/friend-profile',
        builder: (BuildContext context, GoRouterState state) {
          return FriendProfilePage(
            friendId: state.extra as String,
          );
        },
      ),
      GoRoute(
        name: GroupRequestPage.namePage,
        path: '/group-request',
        builder: (BuildContext context, GoRouterState state) {
          return const GroupRequestPage();
        },
      ),
      GoRoute(
        name: GroupCreatePage.namePage,
        path: '/create-group',
        builder: (BuildContext context, GoRouterState state) {
          return const GroupCreatePage();
        },
      ),
      GoRoute(
        name: DevicePage.namePage,
        path: '/devices',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const DevicePage(),
          );
        },
      ),
    ],
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
    redirect: (BuildContext context, GoRouterState state) async {
      if (appBloc.state is AppStateLoading) {
        return shouldRedirect('/splash-screen', state);
      }
      if (appBloc.state is AppStateUnAuthorized) {
        return shouldRedirect('/', state);
      }
      if (appBloc.state is AppStateLoading) {
        return shouldRedirect('/', state);
      }
      log(appBloc.state.toString());
      final st = appBloc.state as AppStateAuthorized;
      if (!st.isEmailVerified) {
        return shouldRedirect('/verify-email', state);
      }
      if (!st.isProfileFilled) {
        return shouldRedirect('/fill-profile', state);
      }
      return shouldRedirect('/home', state);
      // return null;
    },
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: const Scaffold(
          body: Center(
            child: Text('Somethings wrong!'),
          ),
        ),
      );
    },
    debugLogDiagnostics: true,
  );

  String? shouldRedirect(String to, GoRouterState state) {
    if (appBloc.state == GoRouterRefreshStream.latestState) {
      return null;
    }
    if (state.subloc == to) {
      return null;
    }
    return to;
  }
}
