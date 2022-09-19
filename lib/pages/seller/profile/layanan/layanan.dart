import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Layanan Pelanggan",
          style: titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Dimana Saya Dapat Menghubungi Layananan BukaFranchise ?',
              style: titleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              textAlign: TextAlign.justify,
              'CS dengan senang hati selalu siap memberikan pelayanan yang cepat dan terintegrasi melalui layanan digital customer service. Apabila kamu mengalami kendala saat melakukan transaksi atau memiliki pertanyaan seputar BukaFranchise, jangan ragu untuk menghubungi kami.',
              style: regularTextStyle.copyWith(
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Hubungi kami melalui salah satu channel yang telah kami sediakan di bawah',
              style: regularTextStyle.copyWith(
                fontSize: 10,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Whatsapp',
                  style: regularTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' : 08122312323',
                  style: regularTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  'No Telp',
                  style: regularTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' : 021 2332 1212',
                  style: regularTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  'Instagram',
                  style: regularTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' : @bukafranchise',
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
