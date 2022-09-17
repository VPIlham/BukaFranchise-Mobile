import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListBrandPage extends StatefulWidget {
  const ListBrandPage({super.key});

  @override
  State<ListBrandPage> createState() => _ListBrandPageState();
}

class _ListBrandPageState extends State<ListBrandPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar.build(
            context: context, title: const Text("List Brand")));
  }
}
