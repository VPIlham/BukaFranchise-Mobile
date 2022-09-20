import 'package:bukafranchise/pages/buyer/home/widget/banner.dart';
import 'package:bukafranchise/pages/buyer/home/widget/brand.dart';
import 'package:bukafranchise/pages/buyer/home/widget/header_user.dart';
import 'package:bukafranchise/pages/buyer/home/widget/kemitraan.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  //Header User
                  HeaderUserWidget(),
                  const SizedBox(
                    height: 15,
                  ),
                  // //Banner
                  BannerWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  // //Brand Partner
                  BrandWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  //Kemitraan
                  KemitraanWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
