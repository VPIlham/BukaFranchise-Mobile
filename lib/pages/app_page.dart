// ignore_for_file: use_build_context_synchronously

import 'package:bukafranchise/bloc/auth/auth_bloc.dart';
import 'package:bukafranchise/pages/buyer/brand/list_brand.dart';
import 'package:bukafranchise/pages/buyer/widget/bottom_navbar.dart';
import 'package:bukafranchise/pages/login.dart';
import 'package:bukafranchise/pages/seller/widget/BottomNavbarSeller.dart';
import 'package:bukafranchise/repositories/auth_repository.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  //case ketika keluar app mau masuk home
  void _redirect() async {
    final userId = await getUserId();
    final role = await getRoleUser();
    if (userId != null) {
      if (role == 'buyer') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomNavbarPage()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const BottomNavbarSellerPage()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        //case ketika login mau masuk home
        if (state.status == AuthenticationStatus.unauthenticated) {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        } else if (state.status == AuthenticationStatus.authenticated) {
          final role = state.user.role;
          if (role == 'buyer') {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const BottomNavbarPage()));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const BottomNavbarSellerPage()));
          }
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
