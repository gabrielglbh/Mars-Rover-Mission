import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/widgets/mrm_dialog.dart';

class InfoDialog extends StatelessWidget {
  final GenMapBloc bloc;
  const InfoDialog({
    Key? key,
    required this.bloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MRMDialog(
      title: Text("map_gen_map_data".tr(), style: Theme.of(context).textTheme.caption),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "map_gen_map_data_map_dimen".tr(),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold
                    )
                ),
                TextSpan(
                    text: (bloc.params.mapX ?? 0).toString(),
                    style: Theme.of(context).textTheme.bodyText1
                ),
                TextSpan(
                    text: " x ",
                    style: Theme.of(context).textTheme.bodyText1
                ),
                TextSpan(
                    text: (bloc.params.mapY ?? 0).toString(),
                    style: Theme.of(context).textTheme.bodyText1
                ),
              ]
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "map_gen_map_data_obstacles".tr(),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold
                    )
                ),
                TextSpan(
                    text: (bloc.params.obstacles ?? 0).toString(),
                    style: Theme.of(context).textTheme.bodyText1
                ),
              ]
            )
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "map_gen_map_data_rover_pos".tr(),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold
                    )
                ),
                TextSpan(
                    text: (bloc.params.roverX ?? 0).toString(),
                    style: Theme.of(context).textTheme.bodyText1
                ),
                TextSpan(
                    text: " x ",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold
                    )
                ),
                TextSpan(
                    text: (bloc.params.roverY ?? 0).toString(),
                    style: Theme.of(context).textTheme.bodyText1
                ),
                TextSpan(
                    text: "map_gen_map_data_rover_direction".tr(),
                    style: Theme.of(context).textTheme.bodyText1
                ),
                TextSpan(
                    text: bloc.params.direction?.parsed ?? "R",
                    style: Theme.of(context).textTheme.bodyText1
                ),
              ]
            ),
          ),
        ],
      ),
      positiveButtonText: "ok_button_label".tr(),
      popDialog: true,
      onPositive: () {}
    );
  }
}

