import 'package:bukafranchise/pages/buyer/brand/detail_brand.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
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
              'Paket Kemitraan',
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
        SizedBox(
          height: 225,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 15, top: 8, bottom: 10),
                width: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(2, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailBrandPage(
                            id: 1,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            '${Assets.imagePath}gb.png',
                            height: 110,
                            width: 115,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Geprek Bensu Express',
                          style: labelTextStyle.copyWith(
                              fontSize: 14, overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Rp22.000.000',
                          style: regularTextStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
