import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

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
          const Text('data')
        ],
      ),
    );
  }
}
