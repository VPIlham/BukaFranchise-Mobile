// ignore_for_file: use_build_context_synchronously

import 'package:bukafranchise/bloc/dashboard/dashboard_cubit.dart';
import 'package:bukafranchise/bloc/product/product_cubit.dart';
import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/pages/seller/home/widget/dashboard.dart';
import 'package:bukafranchise/pages/seller/home/widget/header_user.dart';
import 'package:bukafranchise/pages/seller/home/widget/produk.dart';
import 'package:bukafranchise/pages/seller/home/widget/wishlist.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future refreshPage() async {
    final userId = await getUserId();
    context.read<ProductCubit>().getMyProduct();
    context.read<ProfileCubit>().getProfile(id: userId);
    context.read<DashboardCubit>().getSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 15),
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
                        // MY PRODUK
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
      ),
    );
  }
}
