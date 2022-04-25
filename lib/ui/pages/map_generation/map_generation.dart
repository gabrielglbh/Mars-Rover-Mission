import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/routing/arguments.dart';
import 'package:marsmission/core/routing/pages.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/types/modes.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/pages/map_generation/pages/map_dimension.dart';
import 'package:marsmission/ui/pages/map_generation/pages/map_obstacles.dart';
import 'package:marsmission/ui/widgets/map_actions.dart';
import 'package:marsmission/ui/pages/map_generation/pages/map_rover_direction.dart';
import 'package:marsmission/ui/widgets/mrm_bullet.dart';
import 'package:marsmission/ui/widgets/mrm_info_dialog.dart';
import 'package:marsmission/ui/widgets/mrm_header.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';

class MapGenerationPage extends StatelessWidget {
  MapGenerationPage({Key? key}) : super(key: key);

  final _bloc = GenMapBloc();
  final _controller = PageController();

  _goToPage(int page) {
    _controller.animateToPage(page, duration: Animations.animation300, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return MRMScaffold(
      title: "generate_random_map_button_label".tr(),
      child: BlocProvider<GenMapBloc>(
        create: (_) => _bloc..add(GenMapEventIdle()),
        child: BlocListener<GenMapBloc, GenMapState>(
          listener: (context, state) async {
            if (state is GenMapStateFailure) {
              Utils.instance.createSnackBar(context, state.message);
              Navigator.of(context).pop();
            } else if (state is GenMapStateMapFinished) {
              await Navigator.of(context).pushNamed(Pages.monitor,
                arguments: MonitorPageArgs(params: state.params, mode: Mode.generate)
              );
            }
          },
          child: BlocBuilder<GenMapBloc, GenMapState>(
            builder: (context, state) {
              if (state is GenMapStatePageChanged) {
                return _body(context, state.page);
              } else if (state is GenMapStateInitial) {
                return _body(context, 0);
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    value: null, color: Colors.blue,
                  ),
                );
              }
            },
          ),
        )
      ),
    );
  }

  Widget _info(BuildContext context) {
    return MRMButton(
      title: "map_gen_map_data".tr(),
      height: Sizes.mrmButtonDefaultHeight / 2,
      width: MediaQuery.of(context).size.width / 3,
      color: Colors.black,
      horizontal: Margins.margin8,
      leading: Icons.info_rounded,
      onTap: () => MRMInfoDialog.show(context, _bloc.params)
    );
  }

  Widget _body(BuildContext context, int page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MRMHeader(
          title: MapGenPages.values[page].name,
          subtitle: MapGenPages.values[page].description
        ),
        _info(context),
        Expanded(
          child: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MapDimensionPage(
                bloc: _bloc,
                pageType: MapGenPages.map,
                goToPage: _goToPage
              ),
              MapObstaclesPage(
                bloc: _bloc,
                pageType: MapGenPages.obs,
                goToPage: _goToPage
              ),
              MapDimensionPage(
                bloc: _bloc,
                pageType: MapGenPages.rover,
                goToPage: _goToPage
              ),
              RoverDirectionPage(
                bloc: _bloc,
                pageType: MapGenPages.direction,
                goToPage: _goToPage
              ),
              RoverActionsPage(
                bloc: _bloc,
                pageType: MapGenPages.actions,
                goToPage: _goToPage
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: Margins.margin8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(MapGenPages.values.length, (index) {
              if (index == page) return const MRMBullet(active: true);
              return const MRMBullet();
            }),
          )
        )
      ],
    );
  }
}
