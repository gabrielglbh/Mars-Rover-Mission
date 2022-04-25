import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/pages/map_generation/widgets/navigation_buttons.dart';
import 'package:marsmission/ui/widgets/mrm_rounded_button.dart';
import 'package:marsmission/ui/widgets/mrm_text.dart';

class RoverDirectionPage extends StatefulWidget {
  final GenMapBloc bloc;
  final MapGenPages pageType;
  final Function(int) goToPage;
  const RoverDirectionPage({
    Key? key,
    required this.bloc,
    required this.pageType,
    required this.goToPage
  }) : super(key: key);

  @override
  State<RoverDirectionPage> createState() => _RoverDirectionPageState();
}

class _RoverDirectionPageState extends State<RoverDirectionPage> with AutomaticKeepAliveClientMixin {
  RoverDirection _direction = RoverDirection.E;

  late int next;

  @override
  void initState() {
    next = widget.pageType.index + 1;
    super.initState();
  }

  _updateMapParams() {
    widget.bloc.add(GenMapEventUpdateRoverDirection(next, direction: _direction));
    widget.goToPage(next);
  }

  Widget _button(RoverDirection direction) {
    return AnimatedOpacity(
      duration: Animations.animation300,
      opacity: direction == _direction ? 1 : 0.5,
      child: MRMRoundedButton(
        key: direction.keys,
        onTap: () => setState(() => _direction = direction),
        child: MRMText(text: direction.parsed, style: Theme.of(context).textTheme.button?.copyWith(
            fontSize: FontSizes.fontSize32
        )),
      )
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _button(RoverDirection.N),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _button(RoverDirection.W),
                    _button(RoverDirection.E),
                  ],
                ),
                _button(RoverDirection.S),
              ],
            )
          ),
        ),
        MapGenNavigationButtons(
          forwardKey: Keys.parametrizedDirectionContinue,
          forwardTitle: MapGenPages.values[next].name,
          onBack: () => widget.goToPage(widget.pageType.index - 1),
          onForward: _updateMapParams
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
