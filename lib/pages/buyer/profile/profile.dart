import 'package:bukafranchise/pages/buyer/profile/faq/faq.dart';
import 'package:bukafranchise/pages/buyer/profile/layanan/layanan.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Akun",
          style: titleTextStyle,
        ),
        leading: const Text(''),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shrinkWrap: true,
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    Assets.logoAvatar,
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'John',
                  style: labelTextStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icHeartTick),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Daftar Keinginan',
                        style: regularTextStyle,
                      ),
                    ],
                  ),
                  SvgPicture.asset(Assets.icArrow),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icSettingLine),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Pengaturan Akun',
                        style: regularTextStyle,
                      ),
                    ],
                  ),
                  SvgPicture.asset(Assets.icArrow),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const FaqPage()));
            },
            child: SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icQuestion),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Frequently Asked Questions',
                        style: regularTextStyle,
                      ),
                    ],
                  ),
                  SvgPicture.asset(Assets.icArrow),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const LayananPage()));
            },
            child: SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icHeadphones),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Layanan Pelanggan',
                        style: regularTextStyle,
                      ),
                    ],
                  ),
                  SvgPicture.asset(Assets.icArrow),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icGroup),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Keluar',
                        style: regularTextStyle.copyWith(
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
