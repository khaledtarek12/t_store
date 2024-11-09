import 'package:flutter/material.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/loading/skeltionizer.dart';

class TBrandShammer extends StatelessWidget {
  const TBrandShammer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (p0, p1) => const TShammerEffect(width: 300, height: 80),
    );
  }
}
