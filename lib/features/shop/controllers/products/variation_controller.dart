import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/products/image_controller.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/features/shop/models/product_variation_model.module.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  // variables
  RxMap selectedAtrributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  //Setect Attrioute,and variouon
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    // when attribute is selected first add that attribute to the selectedAtrributes
    final selectedAtrributes =
        Map<String, dynamic>.from(this.selectedAtrributes);
    selectedAtrributes[attributeName] = attributeValue;
    this.selectedAtrributes[attributeName] = attributeValue;

    final selectedVariations = product.productVariations!.firstWhere(
      (element) =>
          isSameAttributesValue(element.attributesValues, selectedAtrributes),
      orElse: () => ProductVariationModel.empty(),
    );

    // Show the selected Variation Image as a Main Image
    if (selectedVariations.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariations.image;
    }

    // Assign Selected Variation
    selectedVariation.value = selectedVariations;

    // Update selected product variation status
    getProductVarationStockStatus();
  }

  // Check If selected attributes matche any variation attributes
  bool isSameAttributesValue(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAtrributes) {
    {
      // If selectedAttributes contains 3 attributes and current variation contains 2 then return.
      if (variationAttributes.length != selectedAtrributes.length) return false;

      // If any of the attributes is different then return. e. q. (Green, Large) x (Green, Snail)
      for (var key in variationAttributes.keys) {
        // Attributes(Key): value which could be (Green. Small. Cotton) etc.
        if (variationAttributes[key] != selectedAtrributes[key]) return false;
      }
      return true;
    }
  }

  // check Attribute avaliabitity / Stock in variation
  Set<String?> getAttributesAvialabiltyInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    // Pass the variantions to check which are available and stock is not 0
    final avaliableVariationAttribute = variations
        .where((element) =>
            element.attributesValues[attributeName] != null &&
            element.attributesValues[attributeName]!.isNotEmpty &&
            element.stock > 0)
        .map((variations) => variations.attributesValues[attributeName])
        .toSet();

    return avaliableVariationAttribute;
  }

  // Check Product Variation Stock Status
  void getProductVarationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  // Reset Setected Attributes when switching proaucts
  void resetSelectedAttributes() {
    selectedAtrributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }
}
