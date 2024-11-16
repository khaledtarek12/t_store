import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:t_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:t_store/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/features/personalization/screens/setting/upload_data.dart';
import 'package:t_store/features/shop/screens/order/order.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutController = AuthenticationRepository.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///...Header
            TPrimaryHeaderContainer(
                chilld: Column(
              children: [
                ///...Account
                TAppbar(
                    title: Text(
                  'Account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.white),
                )),

                ///...User Profile
                const TUserProfileTile(),
                const SizedBox(height: TSizes.spaceBtwScetions),
              ],
            )),

            ///...Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defultSpace),
              child: Column(
                children: [
                  ////...Acount settings
                  const TSectionHeading(
                      title: 'Accont Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shooping delivery address',
                    onTap: () => Get.to(() => const AddressScreen()),
                  ),

                  const TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                  ),

                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),

                  const TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                  ),

                  const TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'List of all the discounted coupons',
                  ),

                  const TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notification',
                    subTitle: 'Set any kind of notification message',
                  ),

                  const TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected accounts',
                  ),

                  ///...App Settings
                  const SizedBox(height: TSizes.spaceBtwScetions),
                  const TSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload Data to your Cloud Firebase',
                    onTap: () => Get.to(() => const UploadDataScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  ///...Logout Button
                  const SizedBox(height: TSizes.spaceBtwScetions),
                  SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () => logoutController.logout(),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            side: const BorderSide(
                                color: TColors.primary, width: 2),
                          ),
                          child: const Text('Logout',
                              style: TextStyle(color: Colors.white)))),
                  const SizedBox(height: TSizes.spaceBtwScetions * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
