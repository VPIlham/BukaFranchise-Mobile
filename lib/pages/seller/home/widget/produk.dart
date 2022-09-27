import 'package:bukafranchise/bloc/product/product_cubit.dart';
import 'package:bukafranchise/pages/seller/produk/detail_produk.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';
import 'package:bukafranchise/utils/constant.dart';

class ProdukWidget extends StatefulWidget {
  const ProdukWidget({super.key});

  @override
  State<ProdukWidget> createState() => _ProdukWidgetState();
}

class _ProdukWidgetState extends State<ProdukWidget> {
  @override
  void initState() {
    _getMyProduct();
    // TODO: implement initState
    super.initState();
  }

  void _getMyProduct() {
    context.read<ProductCubit>().getMyProduct();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.productStatus == ProductStatus.loading) {
          return const LoadingProduk();
        }
        print('STATE PRODUK SAYA = $state');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Produk Saya',
                  style: titleTextStyle.copyWith(letterSpacing: 1),
                ),
                Text(
                  'Lihat semua',
                  style:
                      regularTextStyle.copyWith(color: mainColor, fontSize: 12),
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
                itemCount: (state.products.length) ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      final productId = state.products[index]['id'].toString();
                      print('PRODUCT ID = $productId');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DetailProduk(
                                    productId: productId,
                                  )));
                    },
                    child: Container(
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
                            offset: const Offset(
                                2, 3), // changes position of shadow
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
                                state.products[index]['name']
                                    .toString()
                                    .toTitleCase(),
                                style: titleTextStyle.copyWith(fontSize: 15),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                formatRupiah.format(
                                    int.parse(state.products[index]['price'])),
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
                                    state.products[index]['Brand']['category']
                                        .toString(),
                                    style:
                                        regularTextStyle.copyWith(fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 8,
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}

class LoadingProduk extends StatelessWidget {
  const LoadingProduk({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            width: 200,
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(color: Colors.white),
            child: SkeletonItem(
              child: Column(
                children: [
                  Row(
                    children: [
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.rectangle, width: 90, height: 90),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                              lines: 3,
                              spacing: 6,
                              lineStyle: SkeletonLineStyle(
                                randomLength: true,
                                height: 10,
                                borderRadius: BorderRadius.circular(8),
                                minLength:
                                    MediaQuery.of(context).size.width / 6,
                                maxLength:
                                    MediaQuery.of(context).size.width / 3,
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
