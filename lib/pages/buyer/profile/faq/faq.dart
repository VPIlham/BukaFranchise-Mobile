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
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apa itu BukaFranchise ?',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Di BukaFranchise, kamu bisa menemukan berbagai kemitraan waralaba dan peluang bisnis kredibel. \nTelusuri tawaran yang pas,  selesaikan transaksi dengan mudah, dan mulai jalankan usaha impianmu.',
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
                  'Pertanyaan Seputar Riwayat Transaksi?',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Riwayat Transaksi adalah fitur yang digunakan untuk melihat detail pada status transaksi. Mitra/Buyer dapat filter Riwayat Transaksi berdasarkan status.',
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
                  'Produk yang Dijual Dalam Pengawasan?',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Demi kenyamanan transaksi di BukaFranchise, kami akan melakukan pengawasan pada produk yang kamu jual. Namun tidak perlu khawatir, hal ini dilakukan hanya sementara dan untuk meningkatkan keamanan bertransaksi di BukaFranchise.',
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
                  'Bagaimana Jaga Keamanan Akun BukaFranchise?',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Untuk menjaga keamanan akun BukaFranchise kamu dan mencegah penipuan oleh pihak yang tidak bertanggung jawab, pastikan memahami panduan keamanan berikut:\n1.Rahasiakan data pribadi\n2.Transfer dana sesuai dengan nominal transaksi\n3.Waspada akun penipuan\n4.Mohon berhati-hati apabila mendapatkan pesan dari seseorang untuk mengakses suatu link tertentu.\n5.Waspada informasi hoax. ',
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
                  'Apa Itu Fitur Wishlist Produk?',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Dengan menggunakan fitur Wishlist, kamu dapat menandai produk yang ingin dibeli di kemudian hari. Semua produk yang kamu wishlist akan masuk ke dalam tab Wishlist yang terdapat pada profile BukaFranchise.',
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
                  'Apa yang Akan Dilakukan Search Bar dengan Kata Kunci Saya?',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Kata kunci yang kamu ketik adalah petunjuk bagi kami untuk memahami niat pencarian kamu. Selanjutnya, pemahaman tersebut akan memutuskan hasil seperti apa yang harus kami tampilkan. Pada prosesnya, kami akan melakukan beberapa penyempurnaan pencarian pada kata kunci kamu.',
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
                  'Apa Saja yang Perlu Saya Ketahui Tentang Berjualan di BukaFranchise?',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Bagi kamu pengguna baru BukaFranchise yang ingin mulai berjualan di sini, kamu dapat mencermati informasi seputar hal berikut ini :\n1. Cara membuka toko,\n2. Memproses pesanan dan \n3. Menerima dan dari hasil transaksi penjualannya.',
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
                  'Saya Kena Penipuan',
                  style: titleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Pastikan hanya untuk berdiskusi antara penjual dengan pembeli. Selalu berhati-hati apabila ada pihak tertentu yang menghubungi kamu melalui telepon, SMS, atau media apapun untuk menawarkan hadiah, pinjaman online maupun penawaran lainnya yang mengarahkan kamu untuk melakukan transfer sejumlah uang. Dan hubungi di layanan pelanggan tentang transaksi Anda jika sudah terkena penipuan',
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
        ],
      ),
    );
  }
}
