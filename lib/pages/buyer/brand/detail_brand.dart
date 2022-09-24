// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:bukafranchise/bloc/brand/brand_cubit.dart';
import 'package:bukafranchise/bloc/brand/brand_state.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBrandPage extends StatefulWidget {
  final int id;
  const DetailBrandPage({super.key, required this.id});

  @override
  State<DetailBrandPage> createState() => _DetailBrandPageState();
}

class _DetailBrandPageState extends State<DetailBrandPage> {
  @override
  void initState() {
    getDetailBrand();
    super.initState();
  }

  void getDetailBrand() {
    context.read<BrandCubit>().getBrandId(id: widget.id);
  }

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
      body: BlocConsumer<BrandCubit, BrandState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.brandStatus == BrandStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.brandStatus == BrandStatus.success) {
            print('STATE NYA =  ${state.brand}');
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardBrandWidget(
                      brandName: state.brand['name'],
                      category: state.brand['category'],
                      image:
                          "https://picsum.photos/seed/${Random().nextInt(256)}/400/400",
                      price: '',
                      startOperation:
                          Date.formatTglIndo(state.brand['startOperation']),
                      totalEmployees: state.brand['totalEmployees'].toString(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Profil Brand",
                      style: labelTextStyle,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ExpandableText(
                      state.brand['description'] ?? 'Deskripsi tidak tersedia',
                      style: regularTextStyle,
                      expandText: "Selengkapnya",
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                      collapseText: "Lebih sedikit",
                      linkColor: mainColor,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Daftar Paket",
                      style: labelTextStyle,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 5,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {},
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
                                left: 12, right: 12, top: 12, bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Image.network(
                                    "https://picsum.photos/seed/${Random().nextInt(256)}/400/400",
                                    fit: BoxFit.cover,
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Paket 2 (Kios + Starter Bahan Pertama)",
                                        style: labelTextStyle.copyWith(
                                            fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Rp 20.000.000",
                                        style: regularTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 36,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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
            Expanded(
              child: ClipRRect(
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
                        startOperation,
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
                        totalEmployees,
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
                        category,
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
