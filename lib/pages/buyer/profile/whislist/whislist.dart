import 'dart:math';

import 'package:bukafranchise/bloc/wishlist/wishlist_cubit.dart';
import 'package:bukafranchise/pages/buyer/brand/detail_brand.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {
    // TODO: implement initState
    getWishlist();
    super.initState();
  }

  void getWishlist() {
    context.read<WishlistCubit>().getAllWishlist();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
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
          BlocConsumer<WishlistCubit, WishlistState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              print("STATE WISHLIST = ${state.wishlist}");
              if (state.wishlistStatus == WishlistStatus.loading) {
                return const loadingBrand();
              }
              return (state.wishlist != "" && state.wishlist.length > 0)
                  ? Expanded(
                      child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  clipBehavior: Clip.none,
                                  primary: false,
                                  physics: const ScrollPhysics(),
                                  itemCount: state.wishlist.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1.0 / 1.36,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemBuilder: (context, index) {
                                    print(
                                        'MAP $index = ${state.wishlist[index]}');
                                    int id = state.wishlist[index]["BrandId"];
                                    var nameBrand =
                                        state.wishlist[index]["Brand"]?["name"];
                                    var imageBrand = state.wishlist[index]
                                                ["Brand"]["Upload"] !=
                                            null
                                        ? "$URL_WEB${state.wishlist[index]?["Brand"]["Upload"]?["path"]}"
                                        : null;
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) =>
                                                DetailBrandPage(
                                              id: id,
                                            ),
                                          ),
                                        ).then((value) {
                                          getWishlist();
                                        });
                                      },
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    child: CachedNetworkImage(
                                                      placeholder:
                                                          (context, url) =>
                                                              Image.asset(
                                                        Assets
                                                            .imgBrandPlaceholder,
                                                        height: 117,
                                                        width: 136,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      imageUrl:
                                                          imageBrand ?? '',
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        height: 117,
                                                        width: 136,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                        Assets
                                                            .imgBrandPlaceholder,
                                                        height: 117,
                                                        width: 136,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 0,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        print("KLIK");
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 7, right: 6),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.5),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            child: SvgPicture
                                                                .asset(Assets
                                                                    .icHeartActive)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Text(
                                                nameBrand,
                                                style: labelTextStyle.copyWith(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                Assets.illWishlistEmpty,
                                height: 150,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Belum Ada Data",
                                    style:
                                        labelTextStyle.copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(height: 16),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "Segera jelajahi",
                                      style: regularTextStyle.copyWith(
                                          fontSize: 16, color: Colors.black54),
                                      children: [
                                        TextSpan(
                                            text: " BukaFranchise ",
                                            style: regularTextStyle.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: mainColor)),
                                        TextSpan(
                                            text:
                                                "dan temukan brand keinginanmu")
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
            },
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

class loadingBrand extends StatelessWidget {
  const loadingBrand({
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
