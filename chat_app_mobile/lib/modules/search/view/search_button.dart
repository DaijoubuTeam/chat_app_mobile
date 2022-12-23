import 'package:chat_app_mobile/modules/search/bloc/search_bloc.dart';
import 'package:chat_app_mobile/modules/search/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != "") {
      context.read<SearchBloc>().add(SearchInputChanging(input: query));
    }

    return const SearchResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != "") {
      context.read<SearchBloc>().add(SearchInputChanging(input: query));
    }

    return const SearchResult();
  }
}
