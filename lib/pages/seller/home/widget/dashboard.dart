import 'package:bukafranchise/theme/style.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            height: 80,
            width: 140,
            decoration: BoxDecoration(
                color: mainColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total Pemasukan',
                  style: regularTextStyle.copyWith(
                    color: mainColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  'Rp15.000.000',
                  style: labelTextStyle.copyWith(
                    color: mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: 80,
            width: 140,
            decoration: BoxDecoration(
                color: mainColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total Produk',
                  style: regularTextStyle.copyWith(
                    color: mainColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  '5',
                  style: labelTextStyle.copyWith(
                    color: mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: 80,
            width: 140,
            decoration: BoxDecoration(
                color: mainColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total Pesanan',
                  style: regularTextStyle.copyWith(
                    color: mainColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  '10',
                  style: labelTextStyle.copyWith(
                    color: mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
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
