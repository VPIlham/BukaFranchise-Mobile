import 'package:bukafranchise/pages/seller/home/widget/dashboard.dart';
import 'package:bukafranchise/pages/seller/home/widget/header_user.dart';
import 'package:bukafranchise/pages/seller/home/widget/produk.dart';
import 'package:bukafranchise/pages/seller/home/widget/wishlist.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
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
            ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      //Header
                      const HeaderUser(),
                      const SizedBox(
                        height: 25,
                      ),
                      const DashboardWidget(),
                      const SizedBox(
                        height: 15,
                      ),
                      const ProdukWidget(),
                      const SizedBox(
                        height: 15,
                      ),
                      const WishlistWidget(),
                    ],
                  ),
                ),
                //Header
              ],
            )
          ],
        ),
      ),
    );
  }
}
