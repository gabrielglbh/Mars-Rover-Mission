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

class MapDimensionPage extends StatefulWidget {
  final GenMapBloc bloc;
  final MapGenPages pageType;
  final Function(int) goToPage;
  const MapDimensionPage({
    Key? key,
    required this.bloc,
    required this.pageType,
    required this.goToPage
  }) : super(key: key);

  @override
  State<MapDimensionPage> createState() => _MapDimensionPageState();
}

class _MapDimensionPageState extends State<MapDimensionPage> {
  late TextEditingController _x;
  late TextEditingController _y;
  late FocusNode _xFocus;
  late FocusNode _yFocus;

  late int next;

  @override
  void initState() {
    next = widget.pageType.index + 1;

    _x = TextEditingController();
    _y = TextEditingController();
    _xFocus = FocusNode();
    _yFocus = FocusNode();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _xFocus.addListener(() => _focusListener(_xFocus));
      _yFocus.addListener(() => _focusListener(_yFocus));
    });
    super.initState();
  }

  @override
  void dispose() {
    _x.dispose();
    _y.dispose();
    _xFocus.dispose();
    _yFocus.dispose();
    super.dispose();
  }

  _focusListener(FocusNode f) {
    if (!f.hasFocus) {
      MapGenerationUtils.validationDimens(widget.bloc.params, _x.text, _y.text, widget.pageType);
    }
  }

  _updateMapParams() {
    final val = MapGenerationUtils.validationDimens(widget.bloc.params, _x.text, _y.text, widget.pageType);
    if (val.isNotEmpty) {
      if (widget.pageType == MapGenPages.map) {
        widget.bloc.add(GenMapEventUpdateMap(next, x: val[0], y: val[1]));
      } else if (widget.pageType == MapGenPages.rover) {
        widget.bloc.add(GenMapEventUpdateRoverPosition(next, x: val[0], y: val[1]));
      }
      widget.goToPage(next);
    } else {
      if (widget.pageType == MapGenPages.map) {
        Utils.instance.createSnackBar(context, "map_gen_map_dimensions_error".tr());
      } else if (widget.pageType == MapGenPages.rover) {
        Utils.instance.createSnackBar(context, "map_gen_rover_dimensions_error".tr());
      }
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MRMInput(
                      focusNode: _xFocus,
                      controller: _x,
                      hint: "map_gen_hint_x_map".tr(),
                      onEditingComplete: () => _yFocus.requestFocus()
                    ),
                    const Icon(Icons.clear),
                    MRMInput(
                      focusNode: _yFocus,
                      controller: _y,
                      action: TextInputAction.done,
                      hint: "map_gen_hint_y_map".tr(),
                      onEditingComplete: () {
                        /// Updates the params
                        _yFocus.unfocus();
                        _updateMapParams();
                      }
                    )
                  ],
                ),
              ),
              MRMExampleMap(type: widget.pageType == MapGenPages.map
                  ? ExampleType.park : ExampleType.rover ),
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
