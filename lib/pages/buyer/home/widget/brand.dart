import 'package:bukafranchise/pages/buyer/brand/detail_brand.dart';
import 'package:bukafranchise/pages/buyer/brand/list_brand.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandWidget extends StatefulWidget {
  const BrandWidget({super.key});

  @override
  State<BrandWidget> createState() => _BrandWidgetState();
}

class _BrandWidgetState extends State<BrandWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Brand Partner',
          style: titleTextStyle.copyWith(letterSpacing: 1),
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.count(
          crossAxisCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 0.98,
          children: List.generate(8, growable: false, (index) {
            if (index == 7) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ListBrandPage()));
                },
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xffFAFAFA),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SvgPicture.asset(Assets.icLainya),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Semua',
                      maxLines: 2,
                      style: regularTextStyle.copyWith(
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailBrandPage()),
                  );
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://source.unsplash.com/random/200x200?sig=$index',
                        height: 45,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Geprek Bensu Bandung',
                      maxLines: 2,
                      style: regularTextStyle.copyWith(
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            }
          }),
        ),
      ],
    );
  }
}
