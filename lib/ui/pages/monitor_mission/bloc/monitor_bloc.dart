import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'monitor_event.dart';
part 'monitor_state.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  MonitorBloc() : super(MonitorInitial()) {
    on<MonitorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
