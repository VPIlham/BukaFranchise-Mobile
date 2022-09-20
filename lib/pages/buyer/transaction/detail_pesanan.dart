import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailPesananPage extends StatefulWidget {
  const DetailPesananPage({super.key});

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Detil",
          style: titleTextStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '#22231341',
                      style: titleTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'April 17, 2017',
                      style: regularTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Pembayaran Cicilan',
                  style: regularTextStyle,
                ),
              ],
            ),

            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    child: Image.network(
                      "https://picsum.photos/seed/400/400",
                      fit: BoxFit.cover,
                      width: 123,
                      height: 117,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paket 1 Geprek Bensu',
                          style: titleTextStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          'Rp22.000.000',
                          style: regularTextStyle.copyWith(fontSize: 16),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icTag,
                              height: 12,
                              width: 9,
                            ),
                            Text(
                              ' Industri Makanan & Minuman',
                              style: regularTextStyle.copyWith(fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Status Pengajuan',
              style: titleTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              Assets.icProcess,
              width: 234,
              height: 38,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Pengajuan diproses',
              style: regularTextStyle,
            ),
            Text(
              'Terakhir diperbarui: 21:30:23 WIB, 23 Maret 2022',
              style:
                  regularTextStyle.copyWith(fontSize: 10, color: textDateGray),
            ),
            const SizedBox(
              height: 24,
            ),
            SvgPicture.asset(
              Assets.icFail,
              width: 234,
              height: 38,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Pengajuan dibatalkan',
              style: regularTextStyle,
            ),
            Text(
              'Terakhir diperbarui: 21:30:23 WIB, 23 Maret 2022',
              style:
                  regularTextStyle.copyWith(fontSize: 10, color: textDateGray),
            ),
            const SizedBox(
              height: 24,
            ),
            // SvgPicture.asset(
            //   Assets.icFail,
            //   width: 234,
            //   height: 38,
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Text(
            //   'Pengajuan ditolak',
            //   style: regularTextStyle,
            // ),
            // Text(
            //   'Terakhir diperbarui: 21:30:23 WIB, 23 Maret 2022',
            //   style: regularTextStyle.copyWith(
            //       fontSize: 10, color: textDateGray),
            // ),
            // const SizedBox(
            //   height: 24,
            // ),
            SvgPicture.asset(
              Assets.icSuccess,
              width: 234,
              height: 38,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Pengajuan berhasil',
              style: regularTextStyle,
            ),
            Text(
              'Terakhir diperbarui: 21:30:23 WIB, 23 Maret 2022',
              style:
                  regularTextStyle.copyWith(fontSize: 10, color: textDateGray),
            ),
          ],
        ),
      ),
    );
  }
}
