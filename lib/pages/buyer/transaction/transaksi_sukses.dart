import 'package:bukafranchise/pages/buyer/transaction/transaction.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TransaksiSukses extends StatelessWidget {
  const TransaksiSukses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Transaksi Berhasil",
          style: titleTextStyle,
        ),
        leading: const Text(''),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shrinkWrap: true,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    Assets.paymentSuccess,
                    width: 240,
                    height: 249,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Terima kasih',
                    style: titleTextStyle,
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    'Transaksi Anda telah berhasil dibuat\n Silakan lihat pesanan Anda',
                    style: regularTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const TransactionPage()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                          child: Text(
                        'Lihat Pesanan',
                        style: labelTextStyle.copyWith(
                            color: Colors.white, letterSpacing: 1),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
