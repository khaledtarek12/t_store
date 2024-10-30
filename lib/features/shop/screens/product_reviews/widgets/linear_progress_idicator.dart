import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/progress_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/device/device_utility.dart';

class TRatingProgressBarIndicator extends StatelessWidget {
  const TRatingProgressBarIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(ProgressController(targetValue: value), tag: text);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Flexible(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtility.getScreenWidth() * 0.8,
            child: Obx(
              () => LinearProgressIndicator(
                value:
                    controller.animatedValue.value, 
                minHeight: 11,
                backgroundColor: TColors.grey,
                valueColor: const AlwaysStoppedAnimation(TColors.primary),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
