import 'package:auth_repository/auth_repository.dart' as auth_repository;
import 'package:chat_app_mobile/config/router/go_router_refresh_stream.dart';
import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/modules/chat_detail/view/view.dart';
import 'package:chat_app_mobile/modules/chat_room_detail/view/view.dart';
import 'package:chat_app_mobile/modules/edit_profile/view/view.dart';
import 'package:chat_app_mobile/modules/friend_profile/view/view.dart';
import 'package:chat_app_mobile/modules/friends_request/view/view.dart';
import 'package:chat_app_mobile/modules/group_create/view/group_create_page.dart';
import 'package:chat_app_mobile/modules/home/view/view.dart';
import 'package:chat_app_mobile/modules/login/view/view.dart';
import 'package:chat_app_mobile/modules/notifications/view/view.dart';
import 'package:chat_app_mobile/modules/signup/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart' as user_repository;

import '../../modules/group_request/view/view.dart';

class AppRouter {
  AppRouter({required this.appBloc});

  final AppBloc appBloc;

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
          name: 'login',
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const LoginPage(),
            );
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
            name: ChatDetailPage.namePage,
            path: '/chatRooms/:chatRoomId',
            builder: (BuildContext context, GoRouterState state) {
              final mapStateExtra = state.extra as Map<String, String?>;
              return ChatDetailPage(
                chatRoomId: state.params['chatRoomId']!,
                chatRoomName: mapStateExtra['chatRoomName'],
                chatRoomAvatar: mapStateExtra['chatRoomAvatar'],
              );
            },
            routes: [
              GoRoute(
                name: ChatRoomDetailPage.namePage,
                path: 'chat-rooms-details',
                builder: (BuildContext context, GoRouterState state) {
                  return ChatRoomDetailPage(
                    chatRoomId: state.params['chatRoomId']!,
                  );
                },
              ),
            ]),
        GoRoute(
          name: EditProfilePage.namePage,
          path: '/edit-profile',
          builder: (BuildContext context, GoRouterState state) {
            return const EditProfilePage();
          },
        ),
        GoRoute(
          name: FriendsRequestPage.namePage,
          path: '/friends-request',
          builder: (BuildContext context, GoRouterState state) {
            return const FriendsRequestPage();
          },
        ),
        GoRoute(
          name: FriendProfilePage.namePage,
          path: '/friend-profile',
          builder: (BuildContext context, GoRouterState state) {
            return FriendProfilePage(
              friendInfor: state.extra as user_repository.User,
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
      ],
      refreshListenable: GoRouterRefreshStream(appBloc.stream),
      redirect: (BuildContext context, GoRouterState state) async {
        final bool loginIn = state.subloc == '/';
        final bool signUpIn =
            state.subloc == '/sign-up' || state.subloc == '/verify-email';
        final bool isAuthorized =
            appBloc.authCurrentUser != auth_repository.User.empty;
        if (!isAuthorized) {
          if (signUpIn) return null;
          return loginIn ? null : '/';
        }
        if (loginIn) {
          return '/home';
        }
        return null;
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
      debugLogDiagnostics: true);
}
