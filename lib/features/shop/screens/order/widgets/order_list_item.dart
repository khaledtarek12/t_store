import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/loading/animation_loader.dart';
import 'package:t_store/features/shop/controllers/order_controller.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_function.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TOrderListItem extends StatelessWidget {
  const TOrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    var darkMode = THelperFunction.isDarkMode(context);
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          final emptyWidget = TAnimationLoaderWidgets(
            text: 'Whoops! No Orders Yet!',
            animation: TImages.cartEmpty,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => NavigationMenu()),
          );

          final response = TCloudHelperFunction.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          final orders = snapshot.data!;

          return ListView.separated(
            shrinkWrap: true,
            itemCount: orders.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final order = orders[index];
              return TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundCoIor: darkMode ? TColors.dark : TColors.light,
                child: Column(
                  children: [
                    //...Row1
                    Row(
                      children: [
                        const Icon(Iconsax.ship),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.orderStatusText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(
                                        color: TColors.primary,
                                        fontWeightDelta: 1),
                              ),
                              Text(
                                order.formattedOrderDate,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.arrow_right_34,
                                size: TSizes.iconsSm))
                      ],
                    ),

                    const SizedBox(height: TSizes.spaceBtwItems),
                    //...Row2
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.tag),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Order',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  Text(order.id,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.calendar),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Shipping Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                  Text(order.formattedDeliveryDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
