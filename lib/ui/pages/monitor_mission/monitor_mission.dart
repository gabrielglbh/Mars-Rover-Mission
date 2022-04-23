import 'package:flutter/material.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';

class MonitorMissionPage extends StatelessWidget {
  final MapParams params;
  const MonitorMissionPage({
    Key? key,
    required this.params
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MRMScaffold(
      child: Column(
        children: [
          Expanded(child: Container(color: Colors.red))
        ],
      ),
    );
  }
}
