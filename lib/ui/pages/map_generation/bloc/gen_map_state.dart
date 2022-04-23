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

class GenMapStateMapFinished extends GenMapState {
  final MapParams params;

  const GenMapStateMapFinished(this.params);

  @override
  List<Object> get props => [params];
}

class GenMapStateFailure extends GenMapState {
  final String message;

  const GenMapStateFailure(this.message);

  @override
  List<Object> get props => [message];
}
