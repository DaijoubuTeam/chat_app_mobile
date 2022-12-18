import 'dart:async';
import 'package:chat_app_mobile/modules/app/bloc/app_bloc.dart';
import 'package:flutter/foundation.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<AppState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (AppState state) {
        if (state != latestState) {
          notifyListeners();
          latestState = state;
        }
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  static AppState? latestState;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
