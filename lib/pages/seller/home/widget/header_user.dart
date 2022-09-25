import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class HeaderUser extends StatefulWidget {
  const HeaderUser({super.key});

  @override
  State<HeaderUser> createState() => _HeaderUserState();
}

class _HeaderUserState extends State<HeaderUser> {
  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  void _getProfile() async {
    final id = await getUserId();
    context.read<ProfileCubit>().getProfile(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.profileStatus == ProfileStatus.loading) {
          return const loadingNameUser();
        }
        // final imgServer = "$URL_WEB${state.user.image}";
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat datang,',
                  style: regularTextStyle,
                ),
                Text(
                  '${state.user.name!.toTitleCase()}!',
                  style: titleTextStyle.copyWith(color: mainColor),
                ),
              ],
            ),
            // CircleAvatar(
            //   radius: 25,
            //   foregroundColor: Colors.transparent,
            //   child: CachedNetworkImage(
            //     placeholder: (context, url) =>
            //         const CircularProgressIndicator(),
            //     imageUrl: imgServer,
            //     imageBuilder: (context, imageProvider) => Container(
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         image: DecorationImage(
            //             image: imageProvider, fit: BoxFit.cover),
            //       ),
            //     ),
            //     errorWidget: (context, url, error) => const Icon(Icons.error),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}

class loadingNameUser extends StatelessWidget {
  const loadingNameUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 37,
              width: 120,
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 2,
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      height: 6,
                      borderRadius: BorderRadius.circular(8),
                      maxLength: MediaQuery.of(context).size.width / 3,
                    )),
              ),
            ),
          ],
        ),
        const SkeletonAvatar(
          style: SkeletonAvatarStyle(
              shape: BoxShape.circle, width: 50, height: 50),
        ),
      ],
    );
  }
}
