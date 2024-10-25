import 'package:flutter/material.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/custom_shapes/container/search_container.dart';
import 'package:t_store/common/widgets/images/t_circular_images.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_cion.dart';
import 'package:t_store/common/widgets/texts/brand_text_with_verification_icon.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: TAppbar(
        title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
        actions: [TCartCounterIcon(onPressed: () {})],
      ),
      body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: THelperFunction.isDarkMode(context)
                    ? TColors.balck
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // search bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwScetions),

                      // Featured Brands
                      TSectionHeading(
                        title: 'Featured Brands',
                        onPressed: () {},
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (p0, p1) => InkWell(
                          borderRadius:
                              BorderRadius.circular(TSizes.cardRadiusLg),
                          onTap: () {},
                          child: TRoundedContainer(
                            padding: const EdgeInsets.all(TSizes.sm),
                            showBorder: true,
                            backgroundCoIor: Colors.transparent,
                            child: Row(
                              children: [
                                //// Iocn
                                Flexible(
                                  child: TCircularImage(
                                      image: TImages.clothIcon,
                                      backgroundColor: Colors.transparent,
                                      overLayColor: isDark
                                          ? TColors.white
                                          : TColors.balck),
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems / 2),
                                //// Text
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TBrandTit1ewithVerifiedIcon(
                                        title: 'Nike',
                                        brandTextSized: TextSizes.large,
                                      ),
                                      Text(
                                        '256 Product',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];
          },
          body: Container()),
    );
  }
}
