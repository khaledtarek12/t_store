import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/shammer/brand_shammer.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/appbar/tabar.dart';
import 'package:t_store/common/widgets/custom_shapes/container/search_container.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_cion.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/common/widgets/brands/brand_cards.dart';
import 'package:t_store/features/shop/controllers/brand_controller.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/screens/barnds/all_prands.dart';
import 'package:t_store/features/shop/screens/barnds/brands_product.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categroies = CategoryController.instance.featuredCateogries;
    final brandController = Get.put(BrandController());
    return DefaultTabController(
      initialIndex: 0,
      length: categroies.length,
      child: Scaffold(
        appBar: TAppbar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [TCartCounterIcon(onPressed: () {})],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  pinned: true,
                  floating: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: THelperFunction.isDarkMode(context)
                      ? TColors.black
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
                          onPressed: () =>
                              Get.to(() => const AllPrandsScreen()),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                        Obx(() {
                          if (brandController.isLoading.value) {
                            return const TBrandShammer();
                          }

                          if (brandController.featureBrand.isEmpty) {
                            return Center(
                              child: Text(
                                'No Data Found!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: Colors.white),
                              ),
                            );
                          }

                          return TGridLayout(
                            itemCount: brandController.featureBrand.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.featureBrand[index];
                              return TBrandCard(
                                showBoder: true,
                                brand: brand,
                                onTap: () => Get.to(
                                    () => BrandsProductScreen(brand: brand)),
                              );
                            },
                          );
                        })
                      ],
                    ),
                  ),

                  //...Tabs
                  bottom: TTabar(
                    tabs: categroies
                        .map((element) => Tab(child: Text(element.name)))
                        .toList(),
                  )),
            ];
          },
          body: TabBarView(
              children: categroies
                  .map((element) => TCategoryTab(category: element))
                  .toList()),
        ),
      ),
    );
  }
}
