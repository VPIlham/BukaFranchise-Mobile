import 'package:bukafranchise/bloc/brand/brand_cubit.dart';
import 'package:bukafranchise/bloc/product/product_cubit.dart';
import 'package:bukafranchise/pages/buyer/brand/detail_brand.dart';
import 'package:bukafranchise/pages/buyer/brand/list_brand_item.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:validators/sanitizers.dart';

class KemitraanWidget extends StatefulWidget {
  const KemitraanWidget({super.key});

  @override
  State<KemitraanWidget> createState() => _KemitraanWidgetState();
}

class _KemitraanWidgetState extends State<KemitraanWidget> {
  @override
  void initState() {
    // TODO: implement initState
    _getBrandItems();
    super.initState();
  }

  void _getBrandItems() {
    context.read<ProductCubit>().getAllProducts(pageSize: 10);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.productStatus == ProductStatus.loading) {
          return loadingProductHome();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Paket Kemitraan',
                  style: titleTextStyle.copyWith(letterSpacing: 1),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const ListBrandItemPage()),
                    );
                  },
                  child: Text(
                    'Lihat semua',
                    style: regularTextStyle.copyWith(
                        color: mainColor, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 225,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.products?.length ?? 0,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 15, top: 8, bottom: 10),
                    width: 135,
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
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailBrandPage(
                                id: 1,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: CachedNetworkImage(
                                  placeholder: (context, url) => Image.asset(
                                        Assets.imgBrandPlaceholder,
                                        height: 110,
                                        width: 115,
                                        fit: BoxFit.cover,
                                      ),
                                  imageUrl: state.products[index]['Upload'] !=
                                          null
                                      ? "$URL_WEB${state.products[index]['Upload']['path']}"
                                      : '',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        height: 110,
                                        width: 115,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      Assets.imgBrandPlaceholder,
                                      height: 110,
                                      width: 115,
                                      fit: BoxFit.cover,
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              state.products[index]["name"],
                              style: labelTextStyle.copyWith(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              formatRupiah.format(
                                  toInt(state.products[index]['price'])),
                              style: regularTextStyle.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
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

class loadingProductHome extends StatelessWidget {
  const loadingProductHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 12,
                width: 169,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 12,
                width: 78,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 225,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(color: Colors.white),
                child: SkeletonItem(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.rectangle, width: 115, height: 110),
                      ),
                      const SizedBox(height: 8),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: 115,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          width: 78,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
