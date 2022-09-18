import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Pesanan Saya",
          style: titleTextStyle,
        ),
        leading: const Text(''),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        '28 Agustus 2022',
                        style: labelTextStyle.copyWith(
                          color: textDateGray,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://source.unsplash.com/random/200x200',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kopi Kenangan Paket 2 (Kios + Starter Bahan Pertama)',
                              style: labelTextStyle.copyWith(fontSize: 12),
                            ),
                            Text(
                              'Pembayaran Cicilan',
                              style: labelTextStyle.copyWith(
                                color: textDateGray,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'Rp. 30000',
                              style: regularTextStyle.copyWith(
                                fontSize: 10,
                              ),
                            ),
                            Container(
                              width: 150,
                              height: 20,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  'Pengajuan diproses',
                                  style: labelTextStyle.copyWith(
                                      color: Colors.white,
                                      letterSpacing: 1,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                            // Container(
                            //   width: 100,
                            //   height: 20,
                            //   decoration: BoxDecoration(
                            //     color: greenColor,
                            //     borderRadius: BorderRadius.circular(16),
                            //   ),
                            //   child: Center(
                            //     child: Text(
                            //       'Terdaftar',
                            //       style: labelTextStyle.copyWith(
                            //           color: Colors.white,
                            //           letterSpacing: 1,
                            //           fontSize: 10),
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   width: 100,
                            //   height: 20,
                            //   decoration: BoxDecoration(
                            //     color: redColor,
                            //     borderRadius: BorderRadius.circular(16),
                            //   ),
                            //   child: Center(
                            //     child: Text(
                            //       'Dibatalkan',
                            //       style: labelTextStyle.copyWith(
                            //           color: Colors.white,
                            //           letterSpacing: 1,
                            //           fontSize: 10),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
