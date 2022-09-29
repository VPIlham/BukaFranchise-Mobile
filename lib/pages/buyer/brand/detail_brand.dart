// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bukafranchise/bloc/brand/brand_cubit.dart';
import 'package:bukafranchise/bloc/brand/brand_state.dart';
import 'package:bukafranchise/bloc/wishlist/wishlist_cubit.dart';
import 'package:bukafranchise/models/brand_item.dart';
import 'package:bukafranchise/pages/buyer/brand/detail_brand_item.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/utils/helpers.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class DetailBrandPage extends StatefulWidget {
  final int id;
  const DetailBrandPage({super.key, required this.id});

  @override
  State<DetailBrandPage> createState() => _DetailBrandPageState();
}

class _DetailBrandPageState extends State<DetailBrandPage> {
  bool isLiked = false;

  @override
  void initState() {
    getDetailBrand();
    super.initState();
  }

  void getDetailBrand() {
    context.read<BrandCubit>().getBrandId(id: widget.id);
  }

  void postLike() {
    context.read<BrandCubit>().postWishlist(id: widget.id);
  }

  void removeLike() {
    context.read<BrandCubit>().removeWishlist(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
          context: context,
          title: const Text(""),
          actions: [
            BlocConsumer<BrandCubit, BrandState>(
              listener: (context, state) {
                print('STATE WISHLIST = $state');
                if (state.brandStatus == BrandStatus.successLiked) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: 'Sukses',
                    desc: 'Terdaftar di daftar keinginan',
                  ).show();
                }

                if (state.brandStatus == BrandStatus.successRemoveLiked) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: 'Sukses',
                    desc: 'Terhapus di daftar keinginan',
                  ).show();
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: InkWell(
                    onTap: () {
                      if (state.brandStatus != BrandStatus.loadingWishlist) {
                        if (state.isLiked == false) {
                          postLike();
                        }
                        if (state.isLiked == true) {
                          removeLike();
                        }
                      }
                    },
                    child: state.isLiked
                        ? SvgPicture.asset(Assets.icHeartActive)
                        : SvgPicture.asset(Assets.icHeart),
                  ),
                );
              },
            )
          ]),
      body: BlocConsumer<BrandCubit, BrandState>(listener: (context, state) {
        print("STATE BRAND PAGE = ${state.brand}");
      }, builder: (context, state) {
        if (state.brandStatus == BrandStatus.loading) {
          return const Center(
            child: SkeletonDetailBrand(),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardBrandWidget(
                  brandName: state.brand['name'],
                  category: state.brand['category'],
                  image: state.brand["Upload"] != null
                      ? "$URL_WEB${state.brand['Upload']?['path']}"
                      : '',
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
                (state.brand["Items"].length > 0)
                    ? ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.brand["Items"].length,
                        itemBuilder: (context, index) {
                          var name = state.brand["Items"][index]["name"];
                          var price = state.brand["Items"][index]["price"];
                          var imgUrl = state.brand["Items"][index]["Upload"] !=
                                  null
                              ? "$URL_WEB${state.brand["Items"][index]?["Upload"]["path"]}"
                              : '';
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => DetailBrandItemPage(
                                    item: BrandItem.fromJson(
                                        state.brand["Items"][index]),
                                  ),
                                ),
                              );
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
                                    left: 12, right: 12, top: 12, bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        imageUrl: imgUrl,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          Assets.imgBrandPlaceholder,
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
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
                                            name,
                                            style: labelTextStyle.copyWith(
                                                fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Rp. ${kmbGenerator(int.parse(price ?? "0"))}",
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
                          );
                        })
                    : const Text("Paket kemitraan belum tersedia")
              ],
            ),
          ),
        );
      }),
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
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    Assets.imgBrandPlaceholder,
                    height: 130,
                    width: 117,
                    fit: BoxFit.cover,
                  ),
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 130,
                    width: 117,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.imgBrandPlaceholder,
                    height: 130,
                    width: 117,
                    fit: BoxFit.cover,
                  ),
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

class SkeletonDetailBrand extends StatelessWidget {
  const SkeletonDetailBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                    height: 150, borderRadius: BorderRadius.circular(12)),
              ),
              const SizedBox(
                height: 24,
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                    height: 12,
                    width: 94,
                    borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(
                height: 16,
              ),
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  padding: const EdgeInsets.all(0),
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    height: 10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                    height: 12,
                    width: 112,
                    borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
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
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 50,
                          width: 50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 12,
                                  width: 160,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 12,
                                  width: 112,
                                  borderRadius: BorderRadius.circular(8)),
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
              const SizedBox(
                height: 10,
              ),
              Card(
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
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 50,
                          width: 50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 12,
                                  width: 160,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 12,
                                  width: 112,
                                  borderRadius: BorderRadius.circular(8)),
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
            ],
          ),
        ),
      ],
    );
  }
}
