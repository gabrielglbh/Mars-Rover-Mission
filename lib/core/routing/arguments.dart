import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/types/modes.dart';

class MonitorPageArgs {
  final MapParams params;
  final Mode mode;

  const MonitorPageArgs({
    required this.params,
    required this.mode
  });
}