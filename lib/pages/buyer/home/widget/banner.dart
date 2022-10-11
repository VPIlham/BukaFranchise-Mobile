import 'package:bukafranchise/bloc/banner/banner_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  void initState() {
    // TODO: implement initState
    _getBanner();
    super.initState();
  }

  void _getBanner() {
    context.read<BannerCubit>().getBanner();
  }

  final List<String> imgList = [
    '${Assets.imagePath}banner-1.png',
    '${Assets.imagePath}banner-2.png',
  ];

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerCubit, BannerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print("state Banner: $state");
        print("state path : ${state.banners.length}");
        return Column(children: [
          CarouselSlider(
            items: state.banners.isNotEmpty
                ? state.banners.map((item) {
                    return Center(
                        child: CachedNetworkImage(
                            placeholder: (context, url) => ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(18)),
                                  child: Image.asset(
                                    Assets.imgBrandPlaceholder,
                                    height: 150,
                                    width: 346,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            imageUrl: item['Upload'] != null
                                ? "$URL_WEB${item['Upload']['path']}"
                                : '',
                            imageBuilder: (context, imageProvider) => Container(
                                  height: 150,
                                  width: 346,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(18)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                            errorWidget: (context, url, error) {
                              return ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(18)),
                                child: Image.asset(
                                  Assets.imgBrandPlaceholder,
                                  height: 150,
                                  width: 346,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }));
                  }).toList()
                : imgList
                    .map((item) => Center(
                        child:
                            Image.asset(item, fit: BoxFit.cover, width: 1000)))
                    .toList(),
            carouselController: _controller,
            options: CarouselOptions(
                height: 170,
                disableCenter: true,
                aspectRatio: 2,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlay: state.banners.length < 2 ? false : true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: state.banners.isNotEmpty
                ? state.banners.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: _current == entry.key ? 30.0 : 12,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : mainColor)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList()
                : imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: _current == entry.key ? 30.0 : 12,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : mainColor)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
          ),
        ]);
      },
    );
  }
}
