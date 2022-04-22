import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/map_generation_pages.dart';
import 'package:marsmission/core/types/rover_directions.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';

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

class _RoverDirectionPageState extends State<RoverDirectionPage> {
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
    final size = MediaQuery.of(context).size.width / 5;
    return AnimatedOpacity(
      duration: Animations.animation300,
      opacity: direction == _direction ? 1 : 0.5,
      child: GestureDetector(
        onTap: () => setState(() => _direction = direction),
        child: Container(
          width: size, height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          alignment: Alignment.center,
          child: Text(direction.parsed, style: Theme.of(context).textTheme.button?.copyWith(
            fontSize: FontSizes.fontSize32
          ))
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
              child: Column(
                children: [
                  Expanded(child: _button(RoverDirection.N)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _button(RoverDirection.W),
                      _button(RoverDirection.E),
                    ],
                  ),
                  Expanded(child: _button(RoverDirection.S)),
                ],
              )
          ),
        ),
        MRMButton(
            title: MapGenPages.values[next].name,
            height: Sizes.mrmButtonDefaultHeight / 1.5,
            horizontal: Margins.margin8,
            trailing: Icons.arrow_forward_rounded,
            onTap: _updateMapParams
        ),
      ],
    );
  }
}
