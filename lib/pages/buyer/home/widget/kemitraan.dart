import 'package:bukafranchise/theme/style.dart';
import 'package:flutter/material.dart';

class KemitraanWidget extends StatefulWidget {
  const KemitraanWidget({super.key});

  @override
  State<KemitraanWidget> createState() => _KemitraanWidgetState();
}

class _KemitraanWidgetState extends State<KemitraanWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Kemitraan',
              style: titleTextStyle.copyWith(letterSpacing: 1),
            ),
            Text(
              'Lihat semua',
              style: regularTextStyle.copyWith(color: mainColor, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          color: Colors.red,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Text('Ayam'),
              Text('Ayam'),
              Text('Ayam'),
              Text('Ayam'),
            ],
          ),
        )
      ],
    );
  }
}
