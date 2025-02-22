import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/features/personalization/models/address_model.module.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.addressModel,
    required this.onTap,
  });

  final AddressModel addressModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = THelperFunction.isDarkMode(context);
    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == addressModel.id;
        return InkWell(
          onTap: onTap,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.md),
            width: double.infinity,
            showBorder: true,
            backgroundCoIor: selectedAddress
                ? TColors.primary.withValues(alpha: 0.5)
                : Colors.transparent,
            borderCoIor: selectedAddress
                ? Colors.transparent
                : dark
                    ? TColors.darkerGrey
                    : TColors.grey,
            margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? dark
                            ? TColors.light
                            : TColors.primary
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addressModel.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: TSizes.sm / 2),
                    Text(
                      addressModel.formatedPhoneNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: TSizes.sm / 2),
                    SizedBox(
                      width: 300,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        addressModel.toString(),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 5,
                  bottom: 0,
                  child: Icon(
                    Iconsax.safe_home5,
                    color: selectedAddress
                        ? dark
                            ? TColors.primary
                            : TColors.white
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
