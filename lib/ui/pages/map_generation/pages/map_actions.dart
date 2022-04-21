import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/pages/map_generation/widgets/mrm_rounded_button.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';

class RoverActionsPage extends StatefulWidget {
  final GenMapBloc bloc;
  final MapGenPages pageType;
  const RoverActionsPage({
    Key? key,
    required this.bloc,
    required this.pageType
  }) : super(key: key);

  @override
  State<RoverActionsPage> createState() => _RoverActionsPageState();
}

class _RoverActionsPageState extends State<RoverActionsPage> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(Margins.margin8),
                            margin: const EdgeInsets.only(bottom: Margins.margin16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(RRadius.radius16),
                            ),
                            child: Text(_actions.join(" ").replaceAll("RoverAction.", ""),
                                textAlign: TextAlign.justify
                            ),
                          ),
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
                  height: Sizes.mrmButtonDefaultHeight / 1.5,
                  horizontal: Margins.margin8,
                  onTap: () {
                    widget.bloc.add(GenMapEventUpdateActions(actions: _actions));
                  }
              ),
            ],
          ),
        )
      ],
    );
  }
}
