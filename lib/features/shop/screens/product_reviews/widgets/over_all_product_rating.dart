import 'package:flutter/material.dart';
import 'package:t_store/features/shop/screens/product_reviews/widgets/linear_progress_idicator.dart';

class TOverAllproductRating extends StatelessWidget {
  const TOverAllproductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Text('4.8', style: Theme.of(context).textTheme.displayLarge),
        ),
        const Flexible(
          flex: 7,
          child: Column(
            children: [
              TRatingProgressBarIndicator(text: '5', value: 1.0),
              TRatingProgressBarIndicator(text: '4', value: 0.8),
              TRatingProgressBarIndicator(text: '3', value: 0.6),
              TRatingProgressBarIndicator(text: '2', value: 0.4),
              TRatingProgressBarIndicator(text: '1', value: 0.2),
            ],
          ),
        ),
      ],
    );
  }
}
