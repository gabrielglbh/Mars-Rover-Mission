import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsmission/core/constants.dart';
import 'package:marsmission/ui/pages/map_generation/bloc/gen_map_bloc.dart';
import 'package:marsmission/ui/pages/map_generation/pages/map_dimension.dart';
import 'package:marsmission/ui/widgets/mrm_bullet.dart';
import 'package:marsmission/ui/widgets/mrm_button.dart';
import 'package:marsmission/ui/widgets/mrm_scaffold.dart';

class MapGenerationPage extends StatelessWidget {
  MapGenerationPage({Key? key}) : super(key: key);

  final _bloc = GenMapBloc();
  final _controller = PageController();
  final _pageViewWidgets = [
    const MapDimensionPage(),
    Center(child: Container(width: 250, height: 250, color: Colors.red)),
    Center(child: Container(width: 250, height: 250, color: Colors.red)),
    Center(child: Container(width: 250, height: 250, color: Colors.red)),
    Center(child: Container(width: 250, height: 250, color: Colors.red))
  ];

  @override
  Widget build(BuildContext context) {
    return MRMScaffold(
      title: "generate_random_map_button_label".tr(),
      child: BlocProvider<GenMapBloc>(
        create: (_) => _bloc..add(GenMapEventIdle()),
        child: BlocBuilder<GenMapBloc, GenMapState>(
          builder: (context, state) {
            if (state is GenMapStatePageChanged) {
              return _body(state.page);
            } else {
              return _body(0);
            }
          },
        )
      ),
    );
  }

  Widget _body(int page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              _bloc.add(GenMapEventPageChanged(page));
            },
            children: _pageViewWidgets,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: MRMButton(
                title: "Back",
                height: Sizes.mrmButtonDefaultHeight / 1.5,
                horizontal: Margins.margin8,
                disabled: page == 0,
                onTap: () {
                  _controller.animateToPage(page - 1,
                    duration: Animations.animation300,
                    curve: Curves.easeInOut
                  );
                  _bloc.add(GenMapEventPageChanged(_controller.page?.toInt() ?? 0));
                }
              )
            ),
            Expanded(
              child: MRMButton(
                title: "Next",
                height: Sizes.mrmButtonDefaultHeight / 1.5,
                horizontal: Margins.margin8,
                onTap: () {
                  _controller.animateToPage(page + 1,
                    duration: Animations.animation300,
                    curve: Curves.easeInOut
                  );
                  _bloc.add(GenMapEventPageChanged(_controller.page?.toInt() ?? 0));
                }
              )
            )
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: Margins.margin16, top: Margins.margin8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pageViewWidgets.length, (index) {
                if (index == page) return const MRMBullet(active: true);
                return const MRMBullet();
              }),
            )
        )
      ],
    );
  }
}
