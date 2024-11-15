import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/styles/custom_animator.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/features/personalization/screens/address/add_new_address.dart';
import 'package:t_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_function.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButtonAnimator: CustomAddAddressAnimator(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppbar(
          showBackArrow: true,
          title: Text('Address',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defultSpace),
          child: Obx(() {
            return FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddress(),
              builder: (context, snapshot) {
                final response = TCloudHelperFunction.checkMultiRecordState(
                    snapshot: snapshot);

                if (response != null) return response;
                final address = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: address.length,
                  itemBuilder: (context, index) => TSingleAddress(
                    addressModel: address[index],
                    onTap: () => controller.selectAddress(address[index]),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
