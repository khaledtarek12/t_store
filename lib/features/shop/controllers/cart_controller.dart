import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/products/variation_controller.dart';
import 'package:t_store/features/shop/models/cart_item_model.module.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/local_storage/storage_utility.dart';
import 'package:t_store/utils/popups/loaders.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // vraibles
  RxInt productQuantityInCart = 0.obs;
  RxInt noOfCartItem = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  RxDouble totalCartPrice = 0.0.obs;
  final variationController = VariationController.instance;

  @override
  void onInit() {
    loadCartItems();
    super.onInit();
  }

  // add items to the cart
  void addToCart(ProductModel product) {
    // Quantity Check
    if (productQuantityInCart.value < 1) {
      TLoaders.customToast(message: 'Select Quantity');
      return;
    }

    // Variation Selected?
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      TLoaders.customToast(message: 'Select Variations');
      return;
    }

    // Out of Stock Status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        TLoaders.warningSnakBar(
            message: 'Selected variation is out of stock.', title: 'Oh Snap!');
        return;
      }
    } else {
      if (product.stock < 1) {
        TLoaders.warningSnakBar(
            message: 'Selected variation is out of stock.', title: 'Oh Snap!');
        return;
      }
    }

    // Convert the ProductModol to a CartTtemModel with the qiven quantity
    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    // Check if already added in the Cart
    int index = cartItems.indexWhere((element) =>
        element.productId == selectedCartItem.productId &&
        element.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      // This quantity is already added or Updated/ Removed from the design (Cart) (-)
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();

    TLoaders.customToast(message: 'your Product has been added to the Cart');
  }

  void addOneToCart(CartItemModel cartItem) {
    int index = cartItems.indexWhere((element) =>
        element.productId == cartItem.productId &&
        element.variationId == cartItem.variationId);
    if (index >= 0) {
      // This quantity is already added or Updated/ Removed from the design (Cart) (-)
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(cartItem);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel cartItem) {
    int index = cartItems.indexWhere((element) =>
        element.productId == cartItem.productId &&
        element.variationId == cartItem.variationId);

    // This quantity is already added or Updated/ Removed from the design (Cart) (-)
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        TLoaders.customToast(message: 'Product removed from the Cart.');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  // Initialize already added Item's Count in the cart.
  void updateAllreadyAddedProductCount(ProductModel product) {
    // If product has no variations tnen calculate cart Entries anc display total number.
    // Else make default entries to O and show cart Entires when variation is selected.
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // Get selected Variation if any...
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  /// This function converts a ProcuctYocet to o CartltemHocet
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset Variation in case of single product type.
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      price: price,
      title: product.title,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbanil,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributesValues : null,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItem();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculateNoOfItems = 0;

    for (var item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculateTotalPrice;
    noOfCartItem.value = calculateNoOfItems;
  }

  void saveCartItem() {
    final cartItemString =
        cartItems.map((element) => element.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems', cartItemString);
  }

  void loadCartItems() {
    final cartItemString =
        TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemString != null) {
      cartItems.assignAll(cartItemString
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());

    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
