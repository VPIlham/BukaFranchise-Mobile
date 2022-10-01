import 'package:bukafranchise/bloc/mostsold/mostsold_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({super.key});

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  @override
  void initState() {
    _getMostSold();
    super.initState();
  }

  void _getMostSold() {
    context.read<MostsoldCubit>().getMostSoldItem();
  }

  @override
  Widget build(BuildContext context) {
    // return LoadingWishlist();
    return BlocConsumer<MostsoldCubit, MostSoldState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print("STATE MOST SOLD = $state");
        if (state.mostSoldStatus == MostSoldStatus.loading) {
          return const LoadingWishlist();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Paling banyak diminati',
                  style: titleTextStyle.copyWith(letterSpacing: 1),
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
                itemCount: state.mostsold?.length ?? 0,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var imgUrl = state.mostsold[index]["Upload"] != null
                      ? "$URL_WEB${state.mostsold[index]["Upload"]["path"]}"
                      : '';
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: CachedNetworkImage(
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              imageUrl: imgUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 110,
                                width: 115,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                Assets.imgBrandPlaceholder,
                                height: 110,
                                width: 115,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            state.mostsold[index]['name'],
                            style: labelTextStyle.copyWith(
                                fontSize: 14, overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            formatRupiah.format(
                                int.parse(state.mostsold[index]['price'])),
                            style: regularTextStyle.copyWith(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${"Terdaftar " + state.mostsold[index]['OrderCount']} kali",
                            style: regularTextStyle.copyWith(fontSize: 12),
                          ),
                        ],
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

class LoadingWishlist extends StatelessWidget {
  const LoadingWishlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185,
      width: double.infinity,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 185,
            width: 120,
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(color: Colors.white),
            child: SkeletonItem(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                            minLength: MediaQuery.of(context).size.width / 6,
                            maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    ),
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
