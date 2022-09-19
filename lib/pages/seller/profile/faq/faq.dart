import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "FAQ",
          style: titleTextStyle,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bagaimana proses di BukaFranchise ?',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Scelerisque ante neque hac bibendum quis nunc molestie interdum nunc. In amet euismod sit erat ac risus laoreet condimentum euismod. Nunc bibendum pellentesque commodo massa quisque suspendisse duis id. Gravida cras quam auctor augue tellus ac.',
                  style: regularTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bagaimana proses di BukaFranchise ?',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Scelerisque ante neque hac bibendum quis nunc molestie interdum nunc. In amet euismod sit erat ac risus laoreet condimentum euismod. Nunc bibendum pellentesque commodo massa quisque suspendisse duis id. Gravida cras quam auctor augue tellus ac.',
                  style: regularTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
