import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/ui/pages/map_generation/widgets/navigation_buttons.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/pages/map_customization/bloc/map_cus_bloc.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/widgets/mrm_rounded_button.dart';
import 'package:marsmission/ui/widgets/mrm_border_container.dart';

import 'mrm_icon_button.dart';
import 'mrm_text.dart';

class RoverActionsPage extends StatefulWidget {
  final Bloc bloc;
  final MapGenPages? pageType;
  final Function(int)? goToPage;
  const RoverActionsPage({
    Key? key,
    required this.bloc,
    this.pageType,
    this.goToPage
  }) : super(key: key);

  @override
  State<RoverActionsPage> createState() => _RoverActionsPageState();
}

class _RoverActionsPageState extends State<RoverActionsPage> with AutomaticKeepAliveClientMixin {
  final List<RoverAction> _actions = [];

  Widget _button(RoverAction action) {
    return Expanded(
      child: MRMRoundedButton(
        key: action.keys,
        ratio: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(action.icon, color: Theme.of(context).brightness == Brightness.light
                ? Colors.white : Colors.black),
            MRMText(
              fit: BoxFit.contain,
              text: action.parsed,
              padding: const EdgeInsets.only(top: Margins.margin4),
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white : Colors.black
              ),
            )
          ],
        ),
        onTap: () => setState(() => _actions.add(action))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
            child: Column(
              children: [
                Expanded(
                  child: MRMBorderContainer(
                    margin: const EdgeInsets.only(bottom: Margins.margin16,
                        left: Margins.margin8, right: Margins.margin8
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: MRMText(
                              text: Utils.instance.sliceWithout(_actions, "RoverAction.", ""),
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                  fontSize: FontSizes.fontSize24
                              ),
                              textAlign: TextAlign.justify
                            ),
                          ),
                        ),
                        _controlButtons()
                      ],
                    ),
                  )
                ),
                Row(
                    children: List.generate(RoverAction.values.length, (index) {
                      return _button(RoverAction.values[index]);
                    })
                )
              ],
            )
          ),
        ),
        MapGenNavigationButtons(
          forwardKey: Keys.navigationBeginMissionTestMap,
          forwardTitle: "finished_map_button_label".tr(),
          showBackButton: widget.bloc is GenMapBloc,
          showTrailing: false,
          onBack: () {
            if (widget.goToPage != null && widget.pageType != null) {
              widget.goToPage!(widget.pageType!.index - 1);
            }
          },
          onForward: () {
            if (widget.bloc is GenMapBloc) {
              widget.bloc.add(GenMapEventUpdateActions(actions: _actions));
            } else if (widget.bloc is MapCusBloc) {
              widget.bloc.add(MapCusEventUpdateActions(actions: _actions));
            }
          }
        )
      ],
    );
  }

  Widget _controlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MRMIconButton(
            width: Sizes.mrmIconButtonSize,
            icon: Icons.clear,
            onTap: () => setState(() => _actions.clear())
        ),
        Expanded(child: Container()),
        MRMIconButton(
            width: Sizes.mrmIconButtonSize,
            icon: Icons.skip_previous_rounded,
            onTap: () => setState(() => _actions.removeLast())
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
