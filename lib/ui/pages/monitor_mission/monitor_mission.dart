import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:marsmission/ui/pages/monitor_mission/bloc/monitor_bloc.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_map.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';

class MonitorMissionPage extends StatelessWidget {
  final MapParams params;
  MonitorMissionPage({
    Key? key,
    required this.params
  }) : super(key: key);

  final _bloc = MonitorBloc();

  @override
  Widget build(BuildContext context) {
    return MRMScaffold(
      title: "monitor_title".tr(),
      child: BlocProvider<MonitorBloc>(
        create: (_) => _bloc..add(MonitorEventIdle()),
        child: Column(
          children: [
            Row(
              children: [
                Text("monitor_actions_label".tr(), style: Theme.of(context).textTheme.caption),
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
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: FontSizes.fontSize26
                        ),
                        maxLines: 1,
                      )
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Expanded(
              flex: 3,
              child: BlocBuilder<MonitorBloc, MonitorState>(
                builder: (context, state) {
                  if (state is MonitorStateUpdateMap) {
                    return _map(state.map, state.direction, false);
                  } else if (state is MonitorStateInitial) {
                    return _map(params.map, params.direction, true);
                  } else if (state is MonitorStateFinished) {
                    // TODO: Finished navigation
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _map(List<List<MapTile>> map, RoverDirection dir, bool showButton) {
    return Column(
      children: [
        MRMMap(
          list: Utils.instance.generateMapFromMatrix(map, dir: dir),
          margin: Margins.margin4,
          mapSize: Misc.testMapSize
        ),
        Visibility(
          visible: showButton,
          child: MRMButton(
            title: "monitor_start_button_label".tr(),
            height: Sizes.mrmButtonDefaultHeight / 2,
            onTap: () {
              if (!_bloc.algorithmHasBegan) _bloc.add(MonitorEventStartSimulation(params));
            }
          ),
        )
      ],
    );
  }
}
