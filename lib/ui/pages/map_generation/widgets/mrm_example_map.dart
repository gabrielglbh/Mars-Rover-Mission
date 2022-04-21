import 'package:flutter/material.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/core/types/example_maps.dart';

class MRMExampleMap extends StatelessWidget {
  final ExampleType type;
  const MRMExampleMap({
    Key? key,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5
        ),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: Margins.margin16),
        physics: const ClampingScrollPhysics(),
        children: type.tiles
      ),
    );
  }
}
