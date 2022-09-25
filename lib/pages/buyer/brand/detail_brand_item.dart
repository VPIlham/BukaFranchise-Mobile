import 'package:bukafranchise/models/brand_item.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailBrandItemPage extends StatelessWidget {
  const DetailBrandItemPage({super.key, required this.item});

  final BrandItem item;

  @override
  Widget build(BuildContext context) {
    print("ITEM DETAIL = ${item.name}");
    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [Text(item.name!)],
        ),
      ),
    );
  }
}
