import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/features/shop/screens/order/widgets/order_list_item.dart';
import 'package:t_store/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
          showBackArrow: true,
          title: Text('My Orders',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defultSpace),
        child: TOrderListItem(),
      ),
    );
  }
}
