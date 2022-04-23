import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsmission/core/algorithm/model.dart';
import 'package:marsmission/core/algorithm/state.dart' as s;
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/routing/arguments.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/modes.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:marsmission/ui/pages/monitor_mission/bloc/monitor_bloc.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/widgets/mrm_info_dialog.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_map.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';
import 'package:marsmission/ui/widgets/mrm_text.dart';

class MonitorMissionPage extends StatelessWidget {
  final MonitorPageArgs args;
  MonitorMissionPage({
    Key? key,
    required this.args
  }) : super(key: key);

  final _bloc = MonitorBloc();

  @override
  Widget build(BuildContext context) {
    final MapParams initialParams = args.params;
    return MRMScaffold(
      title: "monitor_title".tr(),
      child: BlocProvider<MonitorBloc>(
        create: (_) => _bloc..add(MonitorEventIdle()),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(Margins.margin4),
                    margin: const EdgeInsets.only(right: Margins.margin16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(RRadius.radius8),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: BlocBuilder<MonitorBloc, MonitorState>(
                        builder: (context, state) {
                          if (state is MonitorStateUpdateMap) {
                            return _actionLog(context, state.currentActions);
                          }
                          else if (state is MonitorStateFinished) {
                            return _actionLog(context, state.currentActions);
                          }
                          else if (state is MonitorStateInitial) {
                            return _actionLog(context, args.params.actions);
                          }
                          else {
                            return Container();
                          }
                        },
                      )
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline_rounded),
                  onPressed: () => MRMInfoDialog.show(context, initialParams),
                )
              ],
            ),
            Expanded(
              flex: 1,
              child: BlocBuilder<MonitorBloc, MonitorState>(
                builder: (context, state) {
                  if (state is MonitorStateFinished) {
                    return _resultText(context, state);
                  }
                  else {
                    return Container();
                  }
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: BlocBuilder<MonitorBloc, MonitorState>(
                builder: (context, state) {
                  if (state is MonitorStateUpdateMap) {
                    return _content(context, initialParams, state.map,
                        state.currentPath, state.direction, showButton: false
                    );
                  }
                  else if (state is MonitorStateFinished) {
                    return _content(context, initialParams, state.map,
                        state.currentPath, state.direction, hasFinished: true
                    );
                  }
                  else if (state is MonitorStateInitial) {
                    return _content(context, initialParams, args.params.map,
                        [], args.params.direction
                    );
                  }
                  else {
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

  Widget _resultText(BuildContext context, MonitorStateFinished state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(!state.finalState.encounteredObstacle
            ? Icons.check_circle_outline_rounded : Icons.error_outline_rounded,
          color: Colors.red
        ),
        MRMText(
          padding: const EdgeInsets.only(top: Margins.margin8),
          text: !state.finalState.encounteredObstacle
              ? "monitor_finished_good".tr()
              : "${"monitor_finished_bad_1".tr()} "
                "${state.finalState.y}, ${state.finalState.x}. "
                "${"monitor_finished_bad_2".tr()}",
          maxLines: 3,
        )
      ],
    );
  }

  Widget _actionLog(BuildContext context, List<RoverAction> actions) {
    return MRMText(
      text: Utils.instance.sliceWithout(actions, "RoverAction.", ""),
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: FontSizes.fontSize26
      ),
      maxLines: 1
    );
  }

  Widget _content(
      BuildContext context,
      MapParams initialParams,
      List<List<MapTile>> map,
      List<s.State> states,
      RoverDirection dir,
      {bool showButton = true, bool hasFinished = false}
  ) {
    final bool isGeneratedMap = args.mode == Mode.generate;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!isGeneratedMap) MRMMap(
          list: Utils.instance.generateMapFromMatrix(map, dir: dir),
          margin: Margins.margin4,
          mapSize: Misc.testMapSize
        ),
        if (isGeneratedMap) _path(states),
        if (isGeneratedMap) MRMText(
          padding: const EdgeInsets.symmetric(vertical: Margins.margin4),
          text: "monitor_map_exceeding".tr(),
        ),
        Visibility(
          visible: showButton,
          child: MRMButton(
            title: !hasFinished
                ? "monitor_start_button_label".tr()
                : isGeneratedMap
                ? "randomize_obs_button_label".tr()
                : "retry_button_label".tr(),
            height: Sizes.mrmButtonDefaultHeight / 1.5,
            onTap: () {
              /// On retry, reset the rover position and direction and try again the algorithm
              if (hasFinished) {
                args.params
                    .copyRoverPosition(roverX: initialParams.roverX, roverY: initialParams.roverY)
                    .copyRoverDirection(direction: initialParams.direction);
                if (isGeneratedMap) {
                  /// On generated, with copyObstacles, we randomize the obstacles each time
                  args.params.copyObstacles(obstacles: args.params.obstacles);
                }
                _bloc.add(MonitorEventStartSimulation(args.params));
              } else {
                if (!_bloc.algorithmHasBegan) {
                  _bloc.add(MonitorEventStartSimulation(args.params));
                }
              }
            }
          ),
        )
      ],
    );
  }

  Widget _path(List<s.State> states) {
    return Expanded(
      child: ListView.builder(
        itemCount: states.length,
        itemBuilder: (context, i) {
          return Row(
            children: [
              MRMText(text: "${i.toString()}:"),
              Expanded(
                child: MRMText(
                  padding: const EdgeInsets.only(left: Margins.margin8),
                  text: "${"map_gen_map_data_rover_pos".tr()} ${states[i].y}, "
                      "${states[i].x} ${"map_gen_map_data_rover_direction".tr()} "
                      "${states[i].direction.parsed}."
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
