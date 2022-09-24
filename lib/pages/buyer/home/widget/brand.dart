import 'package:bukafranchise/bloc/brand/brand_cubit.dart';
import 'package:bukafranchise/bloc/brand/brand_state.dart';
import 'package:bukafranchise/pages/buyer/brand/detail_brand.dart';
import 'package:bukafranchise/pages/buyer/brand/list_brand.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
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
    context.read<BrandCubit>().getAllBrand();
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
        } else if (state.brandStatus == BrandStatus.success) {
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
              GridView.count(
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 0.98,
                children: List.generate(8, growable: false, (index) {
                  if (index == 7) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ListBrandPage()));
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
                              builder: (context) => DetailBrandPage(
                                  id: state.brands[index]['id'])),
                        );
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              'https://source.unsplash.com/random/200x200?sig=$index',
                              height: 45,
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
                }),
              ),
            ],
          );
        }

        return const loadingBrandHome();
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
    return GridView.count(
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
        }));
  }
}
