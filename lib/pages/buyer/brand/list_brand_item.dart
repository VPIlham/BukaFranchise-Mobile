import 'dart:math';

import 'package:bukafranchise/bloc/brand/brand_cubit.dart';
import 'package:bukafranchise/bloc/brand/brand_state.dart';
import 'package:bukafranchise/models/brand_item.dart';
import 'package:bukafranchise/pages/buyer/brand/detail_brand.dart';
import 'package:bukafranchise/pages/buyer/brand/detail_brand_item.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/utils/helpers.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class ListBrandItemPage extends StatefulWidget {
  const ListBrandItemPage({super.key});

  @override
  State<ListBrandItemPage> createState() => _ListBrandItemPageState();
}

class _ListBrandItemPageState extends State<ListBrandItemPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    getBrandItems();
    super.initState();
  }

  void getBrandItems() {
    context.read<BrandCubit>().getAllBrandItems();
  }

  Future onRefresh() {
    return context.read<BrandCubit>().getAllBrandItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: const Text("Daftar Kemitraan"),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(right: 24, left: 24, bottom: 12),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: regularTextStyle,
                  controller: searchController,
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: 'Cari Kemitraan',
                    filled: true,
                    fillColor: inputColorGray,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            BlocConsumer<BrandCubit, BrandState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state.brandStatus == BrandStatus.loading) {
                  return const loadingBrand();
                }
                if (state.brandStatus == BrandStatus.error) {
                  // TODO: buat widget errornya
                  return const loadingBrand();
                }
                return Expanded(
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.brandItems.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 5.0 / 7.5,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => DetailBrandItemPage(
                                            item: BrandItem.fromJson(
                                                state.brandItems[index]),
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
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                Assets.imgBrandPlaceholder,
                                                height: 117,
                                                width: 136,
                                                fit: BoxFit.cover,
                                              ),
                                          imageUrl: state.brands[index]
                                                      ['Upload'] !=
                                                  null
                                              ? "$URL_WEB${state.brands[index]['Upload']['path']}"
                                              : '',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                                    height: 117,
                                                    width: 136,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                          errorWidget: (context, url, error) {
                                            return Image.asset(
                                              Assets.imgBrandPlaceholder,
                                              height: 117,
                                              width: 136,
                                              fit: BoxFit.cover,
                                            );
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      state.brandItems[index]["Brand"]['name'],
                                      style: regularTextStyle.copyWith(
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF8A8A8A)),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      state.brandItems[index]['name'],
                                      style: labelTextStyle.copyWith(
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Rp. ${kmbGenerator(int.parse(state.brandItems[index]["price"] ?? "0"))}",
                                      style: regularTextStyle,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
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