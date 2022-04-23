import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/ui/utils.dart';
import 'package:marsmission/ui/pages/map_customization/bloc/map_cus_bloc.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/pages/map_generation/widgets/mrm_rounded_button.dart';
import 'package:marsmission/ui/widgets/mrm_border_container.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';

import 'mrm_text.dart';

class RoverActionsPage extends StatefulWidget {
  final Bloc bloc;
  const RoverActionsPage({
    Key? key,
    required this.bloc
  }) : super(key: key);

  @override
  State<RoverActionsPage> createState() => _RoverActionsPageState();
}

class _RoverActionsPageState extends State<RoverActionsPage> with AutomaticKeepAliveClientMixin {
  /// Added AutomaticKeepAliveClientMixin for keeping page view state on map_customization
  @override
  bool get wantKeepAlive => true;

  final List<RoverAction> _actions = [];

  Widget _button(RoverAction action) {
    return Expanded(
      child: MRMRoundedButton(
        ratio: 6,
        color: Colors.black,
        icon: action.icon,
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
                      child: MRMText(
                        text: Utils.instance.sliceWithout(_actions, "RoverAction.", ""),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: FontSizes.fontSize24
                        ),
                        textAlign: TextAlign.justify
                      ),
                      margin: const EdgeInsets.only(bottom: Margins.margin16,
                          left: Margins.margin8, right: Margins.margin8
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
        MRMButton(
            title: "finished_map_button_label".tr(),
            horizontal: Margins.margin8,
            onTap: () {
              if (widget.bloc is GenMapBloc) {
                widget.bloc.add(GenMapEventUpdateActions(actions: _actions));
              } else if (widget.bloc is MapCusBloc) {
                widget.bloc.add(MapCusEventUpdateActions(actions: _actions));
              }
            }
        ),
      ],
    );
  }
}
