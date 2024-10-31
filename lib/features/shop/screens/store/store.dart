import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/appbar/tabar.dart';
import 'package:t_store/common/widgets/custom_shapes/container/search_container.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_cion.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/common/widgets/brands/brand_cards.dart';
import 'package:t_store/features/shop/screens/barnds/all_prands.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NavigationController.instance;
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: TAppbar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [TCartCounterIcon(onPressed: () {})],
        ),
        body: NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    pinned: true,
                    floating: true,
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

                          TGridLayout(
                            itemCount: 4,
                            mainAxisExtent: 80,
                            itemBuilder: (p0, p1) =>
                                const TBrandCard(showBoder: true),
                          )
                        ],
                      ),
                    ),

                    //...Tabs
                    bottom: const TTabar(tabs: [
                      Tab(child: Text('Sports')),
                      Tab(child: Text('Furniture')),
                      Tab(child: Text('Electronics')),
                      Tab(child: Text('Clothes')),
                      Tab(child: Text('Cosmetics')),
                    ])),
              ];
            },
            body: const TabBarView(children: [
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
            ])),
      ),
    );
  }
}
