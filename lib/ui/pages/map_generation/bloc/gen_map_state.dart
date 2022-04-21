part of 'gen_map_bloc.dart';

abstract class GenMapState extends Equatable {
  const GenMapState();

  @override
  List<Object> get props => [];
}

class GenMapStateInitial extends GenMapState {}

class GenMapStatePageChanged extends GenMapState {
  final int page;

  const GenMapStatePageChanged(this.page);

  @override
  List<Object> get props => [page];
}
