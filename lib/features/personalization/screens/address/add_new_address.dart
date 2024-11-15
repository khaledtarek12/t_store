import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar:
            const TAppbar(showBackArrow: true, title: Text('Add new Address')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defultSpace),
            child: Form(
              key: controller.addressFormKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: controller.name,
                      focusNode: controller.nameNode,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          TValidator.displayNamevalidator('Name', value),
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(controller.phoneNumberNode),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user), labelText: 'Name')),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                      controller: controller.phoneNumber,
                      focusNode: controller.phoneNumberNode,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          TValidator.phoneNumberValidator(value),
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(controller.streetNode),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.mobile),
                          labelText: 'Phone Number')),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: controller.street,
                            focusNode: controller.streetNode,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                TValidator.displayNamevalidator(
                                    'street', value),
                            onFieldSubmitted: (value) => FocusScope.of(context)
                                .requestFocus(controller.postalCodeNode),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building_31),
                                labelText: 'Street')),
                      ),
                      const SizedBox(width: TSizes.spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                            controller: controller.postalCode,
                            focusNode: controller.postalCodeNode,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                TValidator.displayNamevalidator(
                                    'Postal Code', value),
                            onFieldSubmitted: (value) => FocusScope.of(context)
                                .requestFocus(controller.cityNode),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.code),
                                labelText: 'Postal Code')),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: controller.city,
                            focusNode: controller.cityNode,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                TValidator.displayNamevalidator('City', value),
                            onFieldSubmitted: (value) => FocusScope.of(context)
                                .requestFocus(controller.stateNode),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building),
                                labelText: 'City')),
                      ),
                      const SizedBox(width: TSizes.spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                            controller: controller.state,
                            focusNode: controller.stateNode,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                TValidator.displayNamevalidator('State', value),
                            onFieldSubmitted: (value) => FocusScope.of(context)
                                .requestFocus(controller.countryNode),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.activity),
                                labelText: 'State')),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                      controller: controller.country,
                      focusNode: controller.countryNode,
                      textInputAction: TextInputAction.done,
                      validator: (value) =>
                          TValidator.displayNamevalidator('Country', value),
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).unfocus(),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.global),
                          labelText: 'Country')),
                  const SizedBox(height: TSizes.defultSpace),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => controller.addNewAddress(),
                          child: const Text('Save'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
