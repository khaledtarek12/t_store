import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_function.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final getColor = THelperFunction.getColor(value: text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: getColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? TColors.textWhite : null),
        avatar: getColor
            ? TCircularContainer(
                width: 50,
                height: 50,
                backgroundCoIor: THelperFunction.getColor(value: text)!,
              )
            : null,
        shape: getColor
            ? CircleBorder(
                side: BorderSide(
                    color: getColor
                        ? THelperFunction.getColor(value: text)!
                        : Colors.transparent),
              )
            : null,
        labelPadding: getColor ? EdgeInsets.zero : null,
        padding: getColor ? EdgeInsets.zero : null,
        backgroundColor:
            getColor ? THelperFunction.getColor(value: text) : null,
        selectedColor: getColor ? THelperFunction.getColor(value: text) : null,
      ),
    );
  }
}
