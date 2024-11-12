import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/layouts/grid_layout.dart';
import 'package:t_store/common/shammer/category_shammer.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/icons/circular_icons.dart';
import 'package:t_store/common/widgets/loading/animation_loader.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cart_virtical.dart';
import 'package:t_store/features/shop/controllers/products/favourite_controller.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_function.dart';

class WhishListScreen extends StatelessWidget {
  const WhishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: TAppbar(
          title: Text('Whislist',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TcircularIcon(
                icon: Iconsax.add,
                onPressed: () => Get.to(() => const HomeScreen()))
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Obx(() {
            return FutureBuilder(
                future: controller.favoriteProduct(),
                builder: (context, snapshot) {
                  final emptyWidget = TAnimationLoaderWidgets(
                    text: 'Whoops! WhisList is Empty...',
                    animation: TImages.pencilAnimation,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () =>
                        Get.off(() => const NavigationMenu()),
                  );

                  final loader =
                      TVerticalProductShimmer(itemCount: 6);
                  final widget = TCloudHelperFunction.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget);

                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) => TProductCartVertical(
                      product: products[index],
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }
}
