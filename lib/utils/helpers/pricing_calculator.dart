class TPricingCalculator {
  static double catcutateTotatPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(location);
    double totatPrice = productPrice + taxAmount + shippingCost;
    return totatPrice;
  }

  static String catcuLateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(tocation) {
    return 0.10;
  }

  static double getShippingCost(tocation) {
    return 5.00;
  }

  //sum all cart values and return total amount

  // static double calculateCartTotal({required CartModel cart}) {
  //   return cart.items.map((e) => e.price).fold(0,
  //       (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
  // }
}
