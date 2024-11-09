import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/shammer/category_shammer.dart';
import 'package:t_store/common/widgets/appbar/custom_appbar.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_product.dart';
import 'package:t_store/features/shop/controllers/all_product_contrroller.dart';
import 'package:t_store/features/shop/models/product_model.module.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_function.dart';

class AllProdcutScreen extends StatelessWidget {
  const AllProdcutScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: TAppbar(
          title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                // Check the state of the FutureBuiIder snapshot
                const loader = TVerticalProductShimmer();
                final widget = TCloudHelperFunction.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);

                // Return appropriate widget based on snapshot state
                if (widget != null) return widget;

                final product = snapshot.data!;

                return TSortableProduct(products: product);
              }),
        ),
      ),
    );
  }
}
