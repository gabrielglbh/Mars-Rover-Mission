import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/example_maps.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/utils.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/widgets/map_generation/mrm_example_map.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_input.dart';

class MapObstaclesPage extends StatefulWidget {
  final GenMapBloc bloc;
  final MapGenerationPages pageType;
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
      _validation();
    }
  }

  int _validation() {
    final p = widget.bloc.params;
    /// Number of obstacles must be greater than 0
    /// Number of obstacles must leave space for AT LEAST the rover to be placed
    final max = ((p.mapX ?? 1) * (p.mapY ?? 1)) - 1;
    try {
      final x = int.parse(_x.text);
      if (x >= 0 && x <= max) {
        return x;
      } else {
        throw Exception();
      }
    } catch (err) {
      Utils.instance.createSnackBar(context, "Type in number grater than 0 and must be "
          "less or equal to $max, as the rover has to be placed.");
      return -1;

    }
  }

  _updateMapParams() {
    final val = _validation();
    if (val != -1) {
      widget.bloc.add(GenMapEventPageChanged(1, params: widget.bloc.params.copyWith(
          obstacles: val
      )));
      widget.goToPage(next);
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
                  title: MapGenerationPages.values[next].name,
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
