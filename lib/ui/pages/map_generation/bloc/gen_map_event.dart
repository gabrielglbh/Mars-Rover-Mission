part of 'gen_map_bloc.dart';

abstract class GenMapEvent extends Equatable {
  const GenMapEvent();

  @override
  List<Object> get props => [];
}

class GenMapEventIdle extends GenMapEvent {}

class GenMapEventPageChanged extends GenMapEvent {
  final int page;
  final MapParams? params;

  const GenMapEventPageChanged(this.page, {this.params});

  @override
  List<Object> get props => [page];
}
