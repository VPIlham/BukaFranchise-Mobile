import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/bloc/transaction/transaction_cubit.dart';
import 'package:bukafranchise/pages/buyer/transaction/transaksi_sukses.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class DetailPesananPage extends StatefulWidget {
  final data;
  const DetailPesananPage({super.key, this.data});

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  @override
  void initState() {
    getDetailTransaksi();
    super.initState();
  }

  void getDetailTransaksi() {
    context.read<TransactionCubit>().getOrderById(id: widget.data['id']);
  }

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
      body: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.transactionStatus == TransactionStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          print(
              'MY DATA TRANSACTION = ${state.transaction['logs']['va_numbers']}');
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SelectableText(
                    state.transaction['trxId'],
                    style: titleTextStyle.copyWith(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          Date.formatTglIndo(state.transaction['createdAt']),
                          style: regularTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //  state.transaction['logs']['va_numbers']
                        Text(
                          'Bank ${state.transaction['logs']['va_numbers'][0]['bank'].toString().toUpperCase()}',
                          style: regularTextStyle,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Pembayaran ${state.transaction['statusPayment'].toString().toTitleCase()}',
                          style: regularTextStyle,
                        ),
                      ],
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
                              state.transaction['Item']['name'],
                              style: titleTextStyle.copyWith(fontSize: 16),
                            ),
                            Text(
                              formatRupiah.format(
                                  int.parse(state.transaction['price']) +
                                      int.parse(state.transaction['fee'])),
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
                                  ' ${state.transaction['Item']['Brand']['category']}',
                                  style:
                                      regularTextStyle.copyWith(fontSize: 10),
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

                Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xF9F7FBff),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bank ${state.transaction['logs']['va_numbers'][0]['bank'].toString().toUpperCase()}',
                                style: regularTextStyle.copyWith(
                                    color: Colors.black, fontSize: 12),
                              ),
                              SelectableText(
                                state.transaction['logs']['va_numbers'][0]
                                    ['va_number'],
                                style: labelTextStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: state.transaction['logs']
                                            ['va_numbers'][0]['va_number']
                                        .toString()));
                              },
                              child: Text(
                                textAlign: TextAlign.right,
                                'Salin',
                                style: labelTextStyle.copyWith(
                                  fontSize: 12,
                                  color: greenColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                  style: regularTextStyle.copyWith(
                      fontSize: 10, color: textDateGray),
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
                //   'Pengajuan dibatalkan',
                //   style: regularTextStyle,
                // ),
                // Text(
                //   'Terakhir diperbarui: 21:30:23 WIB, 23 Maret 2022',
                //   style:
                //       regularTextStyle.copyWith(fontSize: 10, color: textDateGray),
                // ),
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
                const SizedBox(
                  height: 24,
                ),
                // SvgPicture.asset(
                //   Assets.icSuccess,
                //   width: 234,
                //   height: 38,
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // Text(
                //   'Pengajuan berhasil',
                //   style: regularTextStyle,
                // ),
                // Text(
                //   'Terakhir diperbarui: 21:30:23 WIB, 23 Maret 2022',
                //   style:
                //       regularTextStyle.copyWith(fontSize: 10, color: textDateGray),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
