import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/types/rover_actions.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
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
  List<RoverAction> _actions = [];

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
                        Expanded(child: Container(color: Colors.red)),
                      ],
                    )
                ),
              ),
              MRMButton(
                  title: "Begin Visualization",
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
