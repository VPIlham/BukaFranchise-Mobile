import 'dart:math';

import 'package:bukafranchise/bloc/brand/brand_cubit.dart';
import 'package:bukafranchise/bloc/brand/brand_state.dart';
import 'package:bukafranchise/pages/buyer/brand/detail_brand.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class ListBrandPage extends StatefulWidget {
  const ListBrandPage({super.key});

  @override
  State<ListBrandPage> createState() => _ListBrandPageState();
}

class _ListBrandPageState extends State<ListBrandPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    getBrand();
    super.initState();
  }

  void getBrand() {
    context.read<BrandCubit>().getAllBrand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: const Text("Daftar Brand"),
      ),
      body: Column(
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
                  hintText: 'Cari brand',
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
              } else if (state.brandStatus == BrandStatus.success) {
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
                          itemCount: (state.brands.length) ?? 0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 5.0 / 6.5,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => DetailBrandPage(
                                            id: state.brands[index]['id'],
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
                                      child: Image.network(
                                        "https://picsum.photos/seed/${Random().nextInt(256)}/400/400",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      state.brands[index]['name'],
                                      style: labelTextStyle.copyWith(
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    )
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
              }
              return const loadingBrand();
            },
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
