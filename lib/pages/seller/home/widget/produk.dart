import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProdukWidget extends StatefulWidget {
  const ProdukWidget({super.key});

  @override
  State<ProdukWidget> createState() => _ProdukWidgetState();
}

class _ProdukWidgetState extends State<ProdukWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Produk Saya',
              style: titleTextStyle,
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
          height: 130,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 335,
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0.2,
                      blurRadius: 3,
                      offset: const Offset(2, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          '${Assets.imagePath}gb.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paket Geprek Bensu',
                          style: titleTextStyle.copyWith(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Rp22.000.000',
                          style: regularTextStyle.copyWith(fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(Assets.icCategory),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Industri Makanan & Minuman',
                              style: regularTextStyle.copyWith(fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 20,
              );
            },
          ),
        )
      ],
    );
  }
}
