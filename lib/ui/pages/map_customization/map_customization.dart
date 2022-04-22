import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/core/types/map_tiles.dart';
import 'package:marsmission/ui/pages/map_customization/bloc/map_cus_bloc.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_header.dart';
import 'package:marsmission/ui/widgets/mrm_map.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';

class MapCustomization extends StatelessWidget {
  MapCustomization({Key? key}) : super(key: key);

  final _bloc = MapCusBloc();

  Widget _button(MapCusStateUpdatedMap state, MapTile tile) {
    return AnimatedContainer(
      duration: Animations.animation300,
      padding: const EdgeInsets.all(Margins.margin2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RRadius.radius16),
          border: Border.all(width: 2, color: state.selected == tile
              ? Colors.black : Colors.white)
      ),
      child: MRMMapTile(
          tile: tile,
          direction: state.dir,
          onTap: () {
            _bloc.add(MapCusEventSetSelectedTile(tile));
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MRMScaffold(
      title: "map_cus_label".tr(),
      child: BlocProvider<MapCusBloc>(
        create: (_) => _bloc..add(MapCusEventInitial()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MRMHeader(title: "map_cus_title".tr(),
                subtitle: "map_cus_description".tr()),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocBuilder<MapCusBloc, MapCusState>(
                    builder: (context, state) {
                      if (state is MapCusStateUpdatedMap) {
                        /// Populate list with matrix from bloc
                        final List<List<MapTile>> m = state.map;
                        final List<MRMMapTile> map = [];

                        for (int x = 0; x < m.length; x++) {
                          for (int y = 0; y < m[x].length; y++) {
                            /// Transform the index from matrix to list only
                            /// for display purposes
                            final pos = x * m.length + y;
                            map.add(MRMMapTile(
                              tile: m[x][y],
                              direction: state.dir,
                              position: pos + 1,
                              onTap: () {
                                _bloc.add(MapCusEventSetTile(x, y, state.selected));
                              },
                            ));
                          }
                        }

                        return Expanded(
                          child: Column(
                            children: [
                              MRMMap(list: map, margin: Margins.margin16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(MapTile.values.length, (index) {
                                  return _button(state, MapTile.values[index]);
                                })
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  MRMButton(
                      title: "finished_map_button_label".tr(),
                      height: Sizes.mrmButtonDefaultHeight / 1.5,
                      horizontal: Margins.margin8,
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(Pages.monitor);
                      }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
