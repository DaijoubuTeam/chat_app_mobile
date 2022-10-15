import 'package:chat_app_mobile/config/router/go_router_refesh_stream.dart';
import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/modules/edit_profile/view/edit_profile_page.dart';
import 'package:chat_app_mobile/modules/friends_request/view/friends_request.dart';
import 'package:chat_app_mobile/modules/home/view/home_page.dart';
import 'package:chat_app_mobile/modules/login/view/login_page.dart';
import 'package:chat_app_mobile/modules/signup/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          name: 'home',
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
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
      ],
      refreshListenable: GoRouterRefreshStream(appBloc.stream),
      redirect: (BuildContext context, GoRouterState state) async {
        final bool logginIn = state.subloc == '/';
        final bool signUpIn =
            state.subloc == '/sign-up' || state.subloc == '/verify-email';
        final bool isAuthorized = appBloc.state.status == AppStatus.authorized;
        if (!isAuthorized) {
          if (signUpIn) return null;
          return logginIn ? null : '/';
        }
        if (logginIn) {
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
