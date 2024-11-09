import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/loading/skeltionizer.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCategoryShammer extends StatelessWidget {
  const TCategoryShammer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) =>
              const SizedBox(width: TSizes.spaceBtwItems),
          itemBuilder: (context, index) => const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image
                  TShammerEffect(width: 55, height: 55, radius: 55),
                  SizedBox(height: TSizes.spaceBtwItems / 2),

                  //Text
                  TShammerEffect(width: 55, height: 8)
                ],
              ),
          itemCount: itemCount),
    );
  }
}
