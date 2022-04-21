import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/utils.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_input.dart';
import 'package:marsmission/ui/widgets/mrm_map_tile.dart';

class MapDimensionPage extends StatefulWidget {
  final GenMapBloc bloc;
  final Function(int) goToPage;
  const MapDimensionPage({
    Key? key,
    required this.bloc,
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

  @override
  void initState() {
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
      _validation();
    }
  }

  List<int> _validation() {
    try {
      final x = int.parse(_x.text);
      final y = int.parse(_y.text);
      /// Default map must be 2x2
      if (x >= 2 && y >= 2) {
        return [x, y];
      } else {
        throw Exception();
      }
    } catch (err) {
      Utils.instance.createSnackBar(context, "Type in numbers grater than 2.");
      return [];

    }
  }

  _updateMapParams() {
    final val = _validation();
    if (val.isNotEmpty) {
      widget.bloc.add(GenMapEventPageChanged(1, params: widget.bloc.params.copyWith(
          mapX: val[0], mapY: val[1]
      )));
      widget.goToPage(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapHeight = MediaQuery.of(context).size.width - Sizes.mrmInputDefaultHeight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "map_gen_map_dimensions".tr(),
          style: Theme.of(context).textTheme.headline5
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Margins.margin32),
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
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6
                  ),
                  shrinkWrap: true,
                  itemCount: 36,
                  itemBuilder: (context, index) {
                    return MRMMapTile(position: index);
                  },
                ),
              ),
              /*SizedBox(
                width: mapHeight,
                height: mapHeight,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 36,
                  itemBuilder: (context, index) {
                    return MRMMapTile(position: index);
                  },
                ),
              ),*/
              MRMButton(
                title: "next_button_label".tr(),
                height: Sizes.mrmButtonDefaultHeight / 1.5,
                horizontal: Margins.margin8,
                onTap: _updateMapParams
              ),
            ],
          ),
        )
      ],
    );
  }
}
