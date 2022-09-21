import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bukafranchise/utils/constant.dart';

class HeaderUserWidget extends StatefulWidget {
  const HeaderUserWidget({super.key});

  @override
  State<HeaderUserWidget> createState() => _HeaderUserWidgetState();
}

class _HeaderUserWidgetState extends State<HeaderUserWidget> {
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
      listener: (context, state) {},
      builder: (context, state) {
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
                  state.user.name!.toTitleCase(),
                  style: titleTextStyle.copyWith(color: mainColor),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                Assets.logoAvatar,
                width: 47,
                height: 47,
              ),
            ),
          ],
        );
      },
    );
  }
}
