import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/chip/choice_chip.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/features/shop/controllers/products/variation_controller.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    final controller = Get.put(VariationController());
    // final salePercentage =
    //     controller.calculateSalesPercentage(product.price, product.salePrice);
    return Obx(() {
      return Column(
        children: [
          //..Selected attributes pric and details
          // Display variation price and stock when some variation is ,selected.
          if (controller.selectedVariation.value.id.isNotEmpty)
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
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              const SizedBox(width: TSizes.spaceBtwItems),

                              //...sale price
                              TProductPriceText(
                                  price: controller.getVariationPrice())
                            ],
                          ),

                          //...Stock
                          Row(
                            children: [
                              const TProductTitleText(
                                  text: 'Stock : ', smallSize: true),
                              Text(controller.variationStockStatus.value,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),

                  //..Varuatlon Description
                  TProductTitleText(
                    text: controller.selectedVariation.value.description ?? '',
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
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                          title: attribute.name ?? '', showActionButton: false),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      Obx(() {
                        return Wrap(
                          spacing: 8,
                          children: attribute.values!.map(
                            (attributevalue) {
                              final isSelected = controller
                                      .selectedAtrributes[attribute.name] ==
                                  attributevalue;

                              final isAvaliable = controller
                                  .getAttributesAvialabiltyInVariation(
                                      product.productVariations!,
                                      attribute.name!)
                                  .contains(attributevalue);

                              return TChoiceChip(
                                  text: attributevalue,
                                  selected: isSelected,
                                  onSelected: isAvaliable
                                      ? (selected) {
                                          if (selected && isAvaliable) {
                                            controller.onAttributeSelected(
                                              product,
                                              attribute.name ?? '',
                                              attributevalue,
                                            );
                                          }
                                        }
                                      : null);
                            },
                          ).toList(),
                        );
                      }),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      );
    });
  }
}
