import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/example_maps.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/utils.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/pages/map_generation/utils.dart';
import 'package:marsmission/ui/pages/map_generation/widgets/mrm_example_map.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_input.dart';

class MapObstaclesPage extends StatefulWidget {
  final GenMapBloc bloc;
  final MapGenPages pageType;
  final Function(int) goToPage;
  const MapObstaclesPage({
    Key? key,
    required this.bloc,
    required this.pageType,
    required this.goToPage
  }) : super(key: key);

  @override
  State<MapObstaclesPage> createState() => _MapObstaclesPageState();
}

class _MapObstaclesPageState extends State<MapObstaclesPage> {
  late TextEditingController _x;
  late FocusNode _xFocus;

  late int next;

  @override
  void initState() {
    next = widget.pageType.index + 1;

    _x = TextEditingController();
    _xFocus = FocusNode();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _xFocus.addListener(() => _focusListener(_xFocus));
    });
    super.initState();
  }

  @override
  void dispose() {
    _x.dispose();
    _xFocus.dispose();
    super.dispose();
  }

  _focusListener(FocusNode f) {
    if (!f.hasFocus) {
      MapGenerationUtils.validationObstacles(widget.bloc.params, _x.text);
    }
  }

  _updateMapParams() {
    final val = MapGenerationUtils.validationObstacles(widget.bloc.params, _x.text);
    if (val != -1) {
      widget.bloc.add(GenMapEventUpdateObstacles(next, obstacles: val));
      widget.goToPage(next);
    } else {
      Utils.instance.createSnackBar(context, "map_gen_obstacles_error".tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
                child: MRMInput(
                  focusNode: _xFocus,
                  controller: _x,
                  hint: "map_gen_hint_N_map".tr(),
                  onEditingComplete: () {
                    /// Updates the params
                    _xFocus.unfocus();
                    _updateMapParams();
                  }
                ),
              ),
              const MRMExampleMap(type: ExampleType.obstacles),
              MRMButton(
                  title: MapGenPages.values[next].name,
                  height: Sizes.mrmButtonDefaultHeight / 1.5,
                  horizontal: Margins.margin8,
                  trailing: Icons.arrow_forward_rounded,
                  onTap: _updateMapParams
              ),
            ],
          ),
        )
      ],
    );
  }
}