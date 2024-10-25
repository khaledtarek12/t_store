import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    this.iconColor,
    required this.onPressed,
  });

  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final black = THelperFunction.isDarkMode(context);
    return IconButton(
        onPressed: onPressed,
        icon: Badge(
          backgroundColor: black ? TColors.white : Colors.black,
          offset: const Offset(8, -10),
          label: Text('6',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: black ? Colors.black : Colors.white)),
          child: Icon(
            Iconsax.shopping_bag,
            color: iconColor ?? (black ? TColors.white : Colors.black),
          ),
        ));
  }
}
