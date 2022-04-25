import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/routing/arguments.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/core/types/modes.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/pages/map_customization/bloc/map_cus_bloc.dart';
import 'package:marsmission/ui/pages/map_customization/pages/interactive_map.dart';
import 'package:marsmission/ui/widgets/map_actions.dart';
import 'package:marsmission/ui/widgets/mrm_bullet.dart';
import 'package:marsmission/ui/widgets/mrm_header.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';

class MapCustomization extends StatelessWidget {
  MapCustomization({Key? key}) : super(key: key);

  final _bloc = MapCusBloc();

  @override
  Widget build(BuildContext context) {
    return MRMScaffold(
      title: "map_cus_label".tr(),
      child: BlocProvider<MapCusBloc>(
        create: (_) => _bloc..add(MapCusEventInitial()),
        child: BlocListener<MapCusBloc, MapCusState>(
          listener: (context, state) async {
            if (state is MapCusStateFailure) {
              Utils.instance.createSnackBar(context, state.message);
            } else if (state is MapCusStateMapFinished) {
              await Navigator.of(context).pushNamed(Pages.monitor,
                  arguments: MonitorPageArgs(params: state.params, mode: Mode.test));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MRMHeader(title: "map_cus_title".tr(),
                  subtitle: "map_cus_description".tr()),
              BlocBuilder<MapCusBloc, MapCusState>(
                builder: (context, state) {
                  if (state is MapCusStateUpdatedMap) {
                    /// Populate list with matrix from bloc
                    final List<List<MapTile>> m = state.map;
                    final map = Utils.instance.generateMapFromMatrix(m, dir: state.dir, onTap: (x, y) {
                      _bloc.add(MapCusEventSetTile(x, y, state.selected));
                    });
                    return _body(state, map);
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(MapCusStateUpdatedMap state, List<MRMMapTile> map) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              key: Keys.navigationTestMapPageView,
              onPageChanged: (page) {
                _bloc.add(MapCusEventGoToPage(page));
              },
              children: [
                MRMInteractiveMap(
                    bloc: _bloc,
                    map: map,
                    selected: state.selected,
                    direction: state.dir
                ),
                RoverActionsPage(bloc: _bloc)
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: Margins.margin8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  if (index == _bloc.page) return const MRMBullet(active: true);
                  return const MRMBullet();
                }),
              )
          )
        ],
      ),
    );
  }
}
