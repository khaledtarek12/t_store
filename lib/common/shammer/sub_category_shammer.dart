import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/loading/skeltionizer.dart';
import 'package:t_store/utils/constants/sizes.dart';

class THorzinalProductShammer extends StatelessWidget {
  const THorzinalProductShammer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: TSizes.spaceBtwScetions),
      height: 120,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (context, index) =>
            SizedBox(width: TSizes.spaceBtwItems),
        itemBuilder: (context, index) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TShammerEffect(width: 120, height: 120),
            SizedBox(width: TSizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: TSizes.spaceBtwItems / 2),
                TShammerEffect(width: 160, height: 15),
                SizedBox(width: TSizes.spaceBtwItems / 2),
                TShammerEffect(width: 110, height: 15),
                SizedBox(width: TSizes.spaceBtwItems / 2),
                TShammerEffect(width: 80, height: 15),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
