import 'package:bukafranchise/pages/seller/home/home.dart';
import 'package:bukafranchise/pages/seller/profile/profile.dart';
import 'package:bukafranchise/pages/seller/transaction/transaction.dart';
import 'package:flutter/material.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavbarSellerPage extends StatefulWidget {
  const BottomNavbarSellerPage({super.key});

  @override
  State<BottomNavbarSellerPage> createState() => _BottomNavbarSellerPageState();
}

class _BottomNavbarSellerPageState extends State<BottomNavbarSellerPage> {
  int selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      selectedNavbar = index;
    });
  }

  final _widgetOptions = [
    const HomePage(),
    const TransactionPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(selectedNavbar),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icHome),
              activeIcon: SvgPicture.asset(Assets.icHomeActive),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icOrder),
              activeIcon: SvgPicture.asset(Assets.icOrderActive),
              label: 'Pesanan',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icProfile),
              activeIcon: SvgPicture.asset(Assets.icProfileActive),
              label: 'Akun',
            ),
          ],
          currentIndex: selectedNavbar,
          selectedItemColor: mainColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 2,
          showUnselectedLabels: true,
          onTap: _changeSelectedNavBar),
    );
  }
}
