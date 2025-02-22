import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_circular_images.dart';
import 'package:t_store/common/widgets/texts/brand_text_with_verification_icon.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/features/shop/controllers/products/product_controller.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalesPercentage(product.price, product.salePrice);
    final dark = THelperFunction.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //..Price & sale price
        Row(
          children: [
            //..sale tag
            TRoundedContainer(
                radius: TSizes.sm,
                backgroundCoIor: TColors.secondey.withValues(alpha: 0.8),
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.sm, vertical: TSizes.xs),
                child: Text('$salePercentage%',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: TColors.black))),
            const SizedBox(width: TSizes.spaceBtwItems),

            //..price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '\$${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              const SizedBox(width: TSizes.spaceBtwItems),
            TProductPriceText(
                price: controller.getProductPrice(product), isLarge: true),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //..Title
        TProductTitleText(text: product.title),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //..Stock status
        Row(
          children: [
            const TProductTitleText(text: 'Status :'),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text(controller.getProductStockStatus(product.stock),
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //..brand
        Row(
          children: [
            TCircularImage(
              image: product.brand!.image,
              width: 32,
              height: 32,
              overLayColor: dark ? TColors.white : TColors.black,
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            TBrandTit1ewithVerifiedIcon(
                title: product.brand != null ? product.brand!.name : '',
                brandTextSized: TextSizes.large),
          ],
        )
      ],
    );
  }
}
