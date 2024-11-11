import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/loading/skeltionizer.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TListTileSahmmer extends StatelessWidget {
  const TListTileSahmmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TShammerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: TSizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TShammerEffect(width: 100, height: 15),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                TShammerEffect(width: 80, height: 12)
              ],
            )
          ],
        )
      ],
    );
  }
}
