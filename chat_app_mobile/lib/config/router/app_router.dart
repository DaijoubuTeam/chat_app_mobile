import 'package:chat_app_mobile/src/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/src/home/view/view.dart';
import 'package:chat_app_mobile/src/login/view/view.dart';
import 'package:chat_app_mobile/src/signup/view/sign_up_page.dart';
import 'package:chat_app_mobile/config/router/go_router_refesh_stream.dart';
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
          name: 'home',
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
      ],
      refreshListenable: GoRouterRefreshStream(appBloc.stream),
      redirect: (BuildContext context, GoRouterState state) async {
        final bool logginIn = state.subloc == '/';
        final bool isAuthorized = appBloc.state.status == AppStatus.authorized;
        if (!isAuthorized) {
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
