import 'package:bukafranchise/bloc/dashboard/dashboard_cubit.dart';
import 'package:bukafranchise/pages/seller/transaction/pencairan.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:validators/sanitizers.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  void initState() {
    _getDashboard();
    super.initState();
  }

  void _getDashboard() {
    context.read<DashboardCubit>().getSummary();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        print('STATE DASHBOARD = $state');

        if (state.dashboardStatus == DashboardStatus.loading) {
          return const LoadingSummary();
        }

        return SizedBox(
          height: 85,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const Pencairan()));
                },
                child: Container(
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
                      FittedBox(
                        child: Text(
                          formatRupiah
                              .format(toInt(state.dashboard['totalIncome'])),
                          style: labelTextStyle.copyWith(
                            color: mainColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      state.dashboard['totalProducts'].toString(),
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
                      state.dashboard['totalOrders'].toString(),
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
      },
    );
  }
}

class LoadingSummary extends StatelessWidget {
  const LoadingSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: double.infinity,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 90,
            width: 150,
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(color: Colors.white),
            child: SkeletonItem(
              child: Column(
                children: [
                  Row(
                    children: [
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.rectangle, width: 50, height: 50),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                              lines: 3,
                              spacing: 6,
                              lineStyle: SkeletonLineStyle(
                                randomLength: true,
                                height: 10,
                                borderRadius: BorderRadius.circular(8),
                                minLength:
                                    MediaQuery.of(context).size.width / 6,
                                maxLength:
                                    MediaQuery.of(context).size.width / 3,
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
