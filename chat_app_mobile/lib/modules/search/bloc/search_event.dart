part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchInputChanging extends SearchEvent {
  const SearchInputChanging({this.input});
  final String? input;

  @override
  List<Object?> get props => [input];
}
