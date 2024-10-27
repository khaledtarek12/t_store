import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';

import '../curvied_shapes/curvied_edges_widgets.dart';
import 'circular_container.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.chilld,
  });

  final Widget chilld;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWdget(
      child: Container(
        color: TColors.primary,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                  backgroundCoIor: TColors.textWhite.withOpacity(0.1)),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                  backgroundCoIor: TColors.textWhite.withOpacity(0.1)),
            ),
            chilld
          ],
        ),
      ),
    );
  }
}
