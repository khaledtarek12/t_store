import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle = '',
    this.trailing,
    this.onTap,
    this.isSubtitle = true,
  });

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final void Function()? onTap;
  final bool isSubtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: TColors.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: isSubtitle
          ? Text(subTitle, style: Theme.of(context).textTheme.labelMedium)
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
