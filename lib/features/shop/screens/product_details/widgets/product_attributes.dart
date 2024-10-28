import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/chip/choice_chip.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);

    return Column(
      children: [
        //..Selected attributes pric and details
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundCoIor: isDark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              //...Price and Stock Staus
              Row(
                children: [
                  const TSectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                              text: 'Price : ', smallSize: true),

                          //...Actual price
                          Text(
                            '\$25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          //...sale price
                          const TProductPriceText(price: '25')
                        ],
                      ),

                      //...Stock
                      Row(
                        children: [
                          const TProductTitleText(
                              text: 'Stock : ', smallSize: true),
                          Text('In Stock',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              //..Varuatlon Description
              const TProductTitleText(
                text:
                    'This is the Descrption of the Product and it can go upto max 4 lines.',
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        //..Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Color', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'Green', selected: true, onSelected: (p0) {}),
                TChoiceChip(text: 'Blue', selected: false, onSelected: (p0) {}),
                TChoiceChip(
                    text: 'Yellow', selected: false, onSelected: (p0) {}),
              ],
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwScetions),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Size', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'EU 34', selected: true, onSelected: (p0) {}),
                TChoiceChip(
                    text: 'EU 36', selected: false, onSelected: (p0) {}),
                TChoiceChip(
                    text: 'EU 38', selected: false, onSelected: (p0) {}),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
