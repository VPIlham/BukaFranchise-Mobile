import 'dart:math';

import 'package:bukafranchise/pages/buyer/brand/detail_brand.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class WhistlistPage extends StatefulWidget {
  const WhistlistPage({super.key});

  @override
  State<WhistlistPage> createState() => _WhistlistPageState();
}

class _WhistlistPageState extends State<WhistlistPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Daftar Keinginan",
          style: titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          // const LoadingWishlist()
          Expanded(
            child: ListView(
              primary: false,
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            const Offset(2, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 25,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1.0 / 1.36,
                              crossAxisCount: 2,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const DetailBrandPage(
                                        id: 1,
                                      )));
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        enableFeedback: false,
                        child: Card(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: Image.network(
                                        "https://picsum.photos/seed/${Random().nextInt(256)}/400/400",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          print('Click');
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 7, right: 6),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: SvgPicture.asset(
                                                  Assets.icHeartActive)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Brand Name",
                                  style: labelTextStyle.copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingWishlist extends StatelessWidget {
  const LoadingWishlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 5.0 / 6.5,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SkeletonItem(
                      child: Column(
                    children: [
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          minHeight: 120,
                          maxHeight: 121,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                          lines: 3,
                          spacing: 6,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 10,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 2,
                          ),
                        ),
                      ),
                    ],
                  )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
