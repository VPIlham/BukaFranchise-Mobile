import 'package:bukafranchise/bloc/brand/brand_cubit.dart';
import 'package:bukafranchise/bloc/brand/brand_state.dart';
import 'package:bukafranchise/pages/buyer/brand/detail_brand.dart';
import 'package:bukafranchise/pages/buyer/brand/list_brand.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class BrandWidget extends StatefulWidget {
  const BrandWidget({super.key});

  @override
  State<BrandWidget> createState() => _BrandWidgetState();
}

class _BrandWidgetState extends State<BrandWidget> {
  @override
  void initState() {
    _getBrand();
    super.initState();
  }

  void _getBrand() {
    context.read<BrandCubit>().getAllBrand(pageSize: 8);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrandCubit, BrandState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print('STATE BRAND =  $state');
        if (state.brandStatus == BrandStatus.loading) {
          return const loadingBrandHome();
        }
        if (state.brandStatus == BrandStatus.error) {
          return const loadingBrandHome();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Brand Partner',
              style: titleTextStyle.copyWith(letterSpacing: 1),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: state.brands.length ?? 0,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, childAspectRatio: 0.98),
              itemBuilder: (context, index) {
                if (index == 7) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                            builder: (context) => const ListBrandPage()),
                      )
                          .then((value) {
                        _getBrand();
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xffFAFAFA),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SvgPicture.asset(Assets.icLainya),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Semua',
                          maxLines: 2,
                          style: regularTextStyle.copyWith(
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailBrandPage(id: state.brands[index]['id'])),
                      );
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Image.asset(
                              Assets.imgBrandPlaceholder,
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                            ),
                            imageUrl: state.brands[index]['Upload'] != null
                                ? "$URL_WEB${state.brands[index]['Upload']['path']}"
                                : '',
                            imageBuilder: (context, imageProvider) => Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              Assets.imgBrandPlaceholder,
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          state.brands[index]['name'],
                          maxLines: 2,
                          style: regularTextStyle.copyWith(
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class loadingBrandHome extends StatelessWidget {
  const loadingBrandHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 12,
            width: 141,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        GridView.count(
            crossAxisCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: 0.98,
            children: List.generate(8, growable: false, (index) {
              return SkeletonItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          shape: BoxShape.circle, width: 40, height: 40),
                    ),
                    const SizedBox(width: 5),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 2,
                          spacing: 6,
                          lineStyle: SkeletonLineStyle(
                            height: 6,
                            borderRadius: BorderRadius.circular(8),
                            maxLength: MediaQuery.of(context).size.width / 7,
                          )),
                    )
                  ],
                ),
              );
            })),
      ],
    );
  }
}
