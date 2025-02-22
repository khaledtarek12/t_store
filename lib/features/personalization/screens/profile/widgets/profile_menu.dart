import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu({
    super.key,
    required this.title,
    required this.value,
    this.onPressed,
    this.icon = IconlyLight.arrowRight2,
  });

  final String title;
  final String value;
  final void Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.apply(
                color: THelperFunction.isDarkMode(context)
                    ? TColors.grey.withValues(alpha: 0.7)
                    : TColors.darkerGrey.withValues(alpha: 0.7)),
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          flex: 3,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
      ],
    );
  }
}
