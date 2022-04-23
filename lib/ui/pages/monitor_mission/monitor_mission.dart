import 'package:flutter/material.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/widgets/mrm_map.dart';
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
      title: "Monitor Mission",
      child: Column(
        children: [
          Row(
            children: [
              Text("Acciones:", style: Theme.of(context).textTheme.caption),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(Margins.margin4),
                  margin: const EdgeInsets.only(left: Margins.margin8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(RRadius.radius8),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      Utils.instance.sliceWithout(params.actions, "RoverAction.", ""),
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          MRMMap(
            list: Utils.instance.generateMapFromMatrix(params.map, dir: params.direction),
            flex: 3,
            margin: Margins.margin4,
            mapSize: Misc.testMapSize
          )
        ],
      ),
    );
  }
}
