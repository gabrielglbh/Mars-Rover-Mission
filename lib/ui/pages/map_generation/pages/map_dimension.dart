import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/example_maps.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/ui/pages/map_generation/widgets/navigation_buttons.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/pages/map_generation/utils.dart';
import 'package:marsmission/ui/widgets/mrm_map.dart';
import 'package:marsmission/ui/widgets/mrm_input.dart';

import '../../../widgets/mrm_text.dart';

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

class _MapDimensionPageState extends State<MapDimensionPage> with AutomaticKeepAliveClientMixin {
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
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MRMInput(
                key: Keys.parametrizedMapX,
                  focusNode: _xFocus,
                  controller: _x,
                  hint: widget.pageType == MapGenPages.map
                      ? "map_gen_hint_x_map".tr() : "map_gen_hint_pos_x_map".tr(),
                  onEditingComplete: () => _yFocus.requestFocus()
              ),
              if (widget.pageType == MapGenPages.map) const Icon(Icons.clear),
              if (widget.pageType == MapGenPages.rover)
                MRMText(text: ",", style: Theme.of(context).textTheme.headline5),
              MRMInput(
                  key: Keys.parametrizedMapY,
                  focusNode: _yFocus,
                  controller: _y,
                  action: TextInputAction.done,
                  hint: widget.pageType == MapGenPages.map
                      ? "map_gen_hint_y_map".tr() : "map_gen_hint_pos_y_map".tr(),
                  onEditingComplete: () {
                    /// Updates the params
                    _yFocus.unfocus();
                    _updateMapParams();
                  }
              )
            ],
          ),
        ),
        MRMMap(
          list: widget.pageType == MapGenPages.map
            ? ExampleType.park.tiles : ExampleType.rover.tiles
        ),
        MapGenNavigationButtons(
          forwardKey: Keys.parametrizedMapContinue,
          forwardTitle: MapGenPages.values[next].name,
          showBackButton: widget.pageType != MapGenPages.map,
          onBack: () => widget.goToPage(widget.pageType.index - 1),
          onForward: _updateMapParams
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
