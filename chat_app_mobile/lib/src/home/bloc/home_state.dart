part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({this.tabIndex = 0});

  final int tabIndex;

  HomeState copyWith({int? tabIndex}) {
    return HomeState(tabIndex: tabIndex ?? this.tabIndex);
  }

  @override
  List<Object?> get props => [tabIndex];
}
