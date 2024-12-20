import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loading/custom_loading.dart';
import 'package:t_store/common/widgets/texts/seaction_heading.dart';
import 'package:t_store/data/repositories/address/address_repositry.dart';
import 'package:t_store/features/personalization/models/address_model.module.dart';
import 'package:t_store/features/personalization/screens/address/add_new_address.dart';
import 'package:t_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_function.dart';
import 'package:t_store/utils/helpers/helper_function.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final addressRepositry = Get.put(AddressRepositry());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  final name = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final phoneNumber = TextEditingController();

  final nameNode = FocusNode();
  final streetNode = FocusNode();
  final postalCodeNode = FocusNode();
  final cityNode = FocusNode();
  final stateNode = FocusNode();
  final countryNode = FocusNode();
  final phoneNumberNode = FocusNode();

  RxBool refreshData = true.obs;

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  Future<List<AddressModel>> getAllUserAddress() async {
    try {
      final address = await addressRepositry.fetchUserAddress();
      selectedAddress.value = address.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return address;
    } catch (e) {
      TLoaders.errorSnakBar(title: 'Address Not Found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddres) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async => false,
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: CustomLoading(
            loadingColor: THelperFunction.isDarkMode(Get.context!)
                ? TColors.white
                : TColors.primary,
          ));

      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepositry.updateSelectedField(
            selectedAddress.value.id, false);
      }

      newSelectedAddres.selectedAddress = true;
      selectedAddress.value = newSelectedAddres;

      await addressRepositry.updateSelectedField(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      TLoaders.errorSnakBar(
          title: 'Error in Selections', message: e.toString());
    }
  }

  Future addNewAddress() async {
    try {
      // loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Address...', TImages.loading);

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepositry.addAddress(address);

      address.id = id;
      await selectAddress(address);

      TFullScreenLoader.stopLoading();

      TLoaders.successSnakBar(
        title: 'Congratulations',
        message: 'your address has been saved successfully.',
      );

      refreshData.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnakBar(title: 'Address Not Found', message: e.toString());
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    state.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: 'Select Address', showActionButton: false),
            SizedBox(height: TSizes.spaceBtwItems),
            FutureBuilder(
              future: getAllUserAddress(),
              builder: (context, snapshot) {
                final response = TCloudHelperFunction.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => TSingleAddress(
                    addressModel: snapshot.data![index],
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => AddNewAddressScreen()),
                child: Text('Add New Address'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
