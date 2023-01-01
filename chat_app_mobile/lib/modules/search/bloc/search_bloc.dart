import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_repository/search_repository.dart' as search_repo;
import 'package:auth_repository/auth_repository.dart' as auth_repo;

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(
    search_repo.SearchRepository searchRepository,
    auth_repo.AuthRepository authRepository,
  )   : _searchRepository = searchRepository,
        _authRepository = authRepository,
        super(const SearchState()) {
    on<SearchInputChanging>(_onSearchInputChanging);
  }

  final auth_repo.AuthRepository _authRepository;
  final search_repo.SearchRepository _searchRepository;

  Future<void> _onSearchInputChanging(
    SearchInputChanging event,
    Emitter<SearchState> emit,
  ) async {
    final bearerToken = await _authRepository.bearToken;
    if (bearerToken != null && event.input != null) {
      final res = await _searchRepository.getSearch(bearerToken, event.input!);
      emit(
        state.copyWith(
          users: res.users.toList(),
          chatrooms: res.chatrooms.toList(),
          messages: res.messages.toList(),
        ),
      );
    }
  }
}
