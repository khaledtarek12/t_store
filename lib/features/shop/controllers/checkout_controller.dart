import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/checkout/payment_tile.dart';
import 'package:t_store/features/shop/models/payment_method_model.module.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  Rx<PaymentMethodModel> selectedPaymentMenthod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMenthod.value =
        PaymentMethodModel(name: 'Paypal', image: TImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) async {
    final selected = await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text('Select Payment Method'),
        message: Text('Choose your preferred payment option'),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Paypal');
              },
              child: TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paypal', image: TImages.paypal))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Google Pay');
              },
              child: TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Google Pay', image: TImages.googlePay))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Apple Pay');
              },
              child: TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Apple Pay', image: TImages.applePay))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'VISA');
              },
              child: TPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'VISA', image: TImages.visa))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Master Card');
              },
              child: TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Master Card', image: TImages.masterCard))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Paytm');
              },
              child: TPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'Paytm', image: TImages.paytm))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Paystack');
              },
              child: TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paystack', image: TImages.payStack))),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'Credit Card');
              },
              child: TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Credit Card', image: TImages.creditCard))),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDefaultAction: true,
          child: Text('Cancel'),
        ),
      ),
    );

    if (selected != null) {
      // Update the selected payment method
      selectedPaymentMenthod.value = PaymentMethodModel(
        name: selected,
        image: getImageForPaymentMethod(selected),
      );
    }
  }

  String getImageForPaymentMethod(String methodName) {
    switch (methodName) {
      case 'Paypal':
        return TImages.paypal;
      case 'Google Pay':
        return TImages.googlePay;
      case 'Apple Pay':
        return TImages.applePay;
      case 'VISA':
        return TImages.visa;
      case 'Master Card':
        return TImages.masterCard;
      case 'Paytm':
        return TImages.paytm;
      case 'Paystack':
        return TImages.payStack;
      case 'Credit Card':
        return TImages.creditCard;
      default:
        return ''; // Fallback image if needed
    }
  }

  
}
