import 'package:bukafranchise/theme/style.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Widget title;
  final Widget? subTitle;
  final Widget? additionalLeading;
  final Widget? trailing;
  final ValueChanged<int> onChanged;
  final CrossAxisAlignment? crossAxisAlignment;
  final double? additionalLeadingWidth;

  const CustomRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subTitle,
    this.trailing,
    this.crossAxisAlignment,
    this.additionalLeading,
    this.additionalLeadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    print('@@@@@@@@@@GROUP VALUE = $groupValue');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // decoration: defaultDecoration.copyWith(color: Colors.white),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8F92A1).withOpacity(0.03),
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
        color: Colors.white,
      ),
      child: ListTile(
        leading: additionalLeading != null
            ? SizedBox(
                width: additionalLeadingWidth ?? 110,
                child: Row(
                  children: [
                    checkList(isSelected),
                    const SizedBox(width: 20),
                    additionalLeading!,
                  ],
                ),
              )
            : checkList(isSelected),
        title: title,
        subtitle: subTitle,
        trailing: trailing,
        onTap: () => onChanged(value),
      ),
    );
  }

  Widget checkList(bool isSelected) {
    return Container(
      width: 30,
      height: 30,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.white,
        shape: BoxShape.circle,
        border:
            Border.all(width: 1, color: isSelected ? mainColor : textDateGray),
      ),
      child: CircleAvatar(
          backgroundColor: isSelected ? mainColor : Colors.transparent),
    );
  }
}
