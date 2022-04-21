import 'package:flutter/material.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';

class MonitorMissionPage extends StatelessWidget {
  const MonitorMissionPage({Key? key}) : super(key: key);

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
