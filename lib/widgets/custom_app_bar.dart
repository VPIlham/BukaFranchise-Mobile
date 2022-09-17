import 'dart:math' as math;

import 'package:bukafranchise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultAppBar {
  static PreferredSizeWidget build({
    required BuildContext context,
    Widget? title,
    Widget? leading,
    PreferredSizeWidget? bottom,
    List<Widget>? actions,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          titleSpacing: 0,
          leadingWidth: 80,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          title: title,
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: actions,
          leading: leading ??
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
          bottom: bottom,
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
    required this.title,
    this.flexibleSpace,
    this.leading,
    required this.actions,
    this.expandedHeight,
    this.backgroundColor,
    this.isRevertColor,
  }) : super(key: key);

  final Widget? title;
  final Widget? flexibleSpace;
  final Widget? leading;
  final List<Widget> actions;
  final double? expandedHeight;
  final Color? backgroundColor;
  final bool? isRevertColor;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      centerTitle: true,
      titleSpacing: 0,
      backgroundColor: backgroundColor,
      title: title,
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace,
      elevation: 0,
      leadingWidth: 40,
      leading: leading ??
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
      actions: actions,
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
