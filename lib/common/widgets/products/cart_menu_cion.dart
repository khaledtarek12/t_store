import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.iconColor,
    required this.onPressed,
  });

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Badge(
          backgroundColor: Colors.black,
          offset: const Offset(8, -10),
          label: Text('6',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.white)),
          child: Icon(
            Iconsax.shopping_bag,
            color: iconColor,
          ),
        ));
  }
}
