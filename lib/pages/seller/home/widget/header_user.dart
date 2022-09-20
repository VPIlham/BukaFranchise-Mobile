import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter/material.dart';

class HeaderUser extends StatelessWidget {
  final String name;
  final String img;

  const HeaderUser({super.key, required this.name, required this.img});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang,',
              style: regularTextStyle,
            ),
            Text(
              '$name!',
              style: titleTextStyle.copyWith(color: mainColor),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            Assets.logoAvatar,
            width: 47,
            height: 47,
          ),
        ),
      ],
    );
  }
}
