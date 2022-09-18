import 'dart:math';

import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailBrandPage extends StatefulWidget {
  const DetailBrandPage({super.key});

  @override
  State<DetailBrandPage> createState() => _DetailBrandPageState();
}

class _DetailBrandPageState extends State<DetailBrandPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
          context: context,
          title: const Text(""),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: IconButton(
                  onPressed: () {}, icon: SvgPicture.asset(Assets.icHeart)),
            )
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              CardBrandWidget(
                brandName: "Kopi Kenangan",
                category: "Industri Makanan dan Minuman",
                image:
                    "https://picsum.photos/seed/${Random().nextInt(256)}/400/400",
                price: "Rp 20.000.000",
                startOperation: "April 17, 2017",
                totalEmployees: "120",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardBrandWidget extends StatelessWidget {
  final String image;
  final String brandName;
  final String price;
  final String startOperation;
  final String totalEmployees;
  final String category;

  const CardBrandWidget({
    Key? key,
    required this.image,
    required this.brandName,
    required this.price,
    required this.startOperation,
    required this.totalEmployees,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(image);
    return Card(
      elevation: 0,
      color: inputColorGray,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: image != null
                  ? Image.network(
                      image,
                      height: 130,
                      width: 117,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      Assets.imgBrandPlaceholder,
                      height: 130,
                      width: 117,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width /
                      3, //this is the total width of your screen
                  child: Text(
                    brandName,
                    maxLines: 2,
                    style: labelTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width /
                      3, //this is the total width of your screen
                  child: Text(
                    "Rp 20.000.000",
                    maxLines: 2,
                    style: regularTextStyle.copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.icCalendar,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width /
                          3, //this is the total width of your screen
                      child: Text(
                        "April 17, 2017",
                        maxLines: 2,
                        style: regularTextStyle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.icPeople,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width /
                          3, //this is the total width of your screen
                      child: Text(
                        "120 Karyawan",
                        maxLines: 2,
                        style: regularTextStyle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.icTag,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width /
                          3, //this is the total width of your screen
                      child: Text(
                        "Industri Makanan dan Minuman",
                        maxLines: 5,
                        style: regularTextStyle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}