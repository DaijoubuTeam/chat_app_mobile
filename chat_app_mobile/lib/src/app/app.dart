import 'package:auth_repository/auth_repository.dart';
import 'package:chat_app_mobile/src/app/bloc/app_bloc.dart';
import 'package:chat_app_mobile/src/home/view/home_page.dart';
import 'package:chat_app_mobile/src/login/view/view.dart';
import 'package:chat_app_mobile/src/signup/view/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(),
        child: MyAppView(),
      ),
    );
  }
}

class MyAppView extends StatelessWidget {
  MyAppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
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
  );
}
