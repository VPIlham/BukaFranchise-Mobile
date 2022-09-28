import 'package:bukafranchise/pages/buyer/home/home.dart';
import 'package:bukafranchise/pages/buyer/profile/profile.dart';
import 'package:bukafranchise/pages/buyer/transaction/transaction.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavbarPage extends StatefulWidget {
  final selectedIndex;
  const BottomNavbarPage({super.key, this.selectedIndex});

  @override
  State<BottomNavbarPage> createState() => _BottomNavbarPageState();
}

class _BottomNavbarPageState extends State<BottomNavbarPage> {
  int selectedNavbar = 0;

  @override
  void initState() {
    if (widget.selectedIndex != null) {
      setState(() {
        selectedNavbar = widget.selectedIndex!;
      });
    }
    super.initState();
  }

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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
      ),
    );
  }
}
