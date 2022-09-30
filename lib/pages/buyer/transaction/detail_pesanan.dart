import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/bloc/transaction/transaction_cubit.dart';
import 'package:bukafranchise/pages/buyer/transaction/transaksi_sukses.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class DetailPesananPage extends StatefulWidget {
  final dynamic data;
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
          print("PRICE ${state.transaction['price']}");
          print("UPLOAD ${state.transaction["Item"]["Upload"]}");

          var imgUrl = state.transaction["Item"]["Upload"] != null
              ? "$URL_WEB${state.transaction["Item"]["Upload"]["path"]}"
              : '';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.transaction['trxId'],
                            style: labelTextStyle,
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Text(
                            Date.formatTglIndo(state.transaction['createdAt']),
                            style: regularTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Bank ${state.transaction['logs']['va_numbers'][0]['bank'].toString().toUpperCase()}',
                            style: labelTextStyle,
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Text(
                            state.transaction['statusPayment'] == 'dp'
                                ? "Pembayaran Uang Muka"
                                : state.transaction['statusPayment'] == 'cash'
                                    ? "Pembayaran Tunai"
                                    : "Pembayaran Cicilan",
                            style: regularTextStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Image.asset(
                              Assets.imgBrandPlaceholder,
                              height: 117,
                              width: 123,
                              fit: BoxFit.cover,
                            ),
                            imageUrl: imgUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 117,
                              width: 123,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              Assets.imgBrandPlaceholder,
                              height: 117,
                              width: 123,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width /
                                1.9, //this is the total width of your screen
                            child: Text(
                              state.transaction['Item']['Brand']['name'],
                              maxLines: 1,
                              style: regularTextStyle.copyWith(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width /
                                1.9, //this is the total width of your screen
                            child: Text(
                              state.transaction['Item']['name'],
                              maxLines: 2,
                              style: labelTextStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width /
                                1.9, //this is the total width of your screen
                            child: Text(
                              formatRupiah.format(state.transaction['price'] +
                                  state.transaction['fee']),
                              style: regularTextStyle.copyWith(fontSize: 18),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xF9F7FBff),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 14, right: 24, top: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: Image.asset(
                                  state.transaction['logs']['va_numbers'][0]
                                              ['bank'] ==
                                          'bni'
                                      ? Assets.logoBNI
                                      : state.transaction['logs']['va_numbers']
                                                  [0]['bank'] ==
                                              'bca'
                                          ? Assets.logoBCA
                                          : Assets.logoBRI,
                                  fit: BoxFit.fill,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bank ${state.transaction['logs']['va_numbers'][0]['bank'].toString().toUpperCase()}',
                                        style: labelTextStyle.copyWith(
                                            fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        state.transaction['logs']['va_numbers']
                                                [0]['va_number']
                                            .toString(),
                                        style: regularTextStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 36,
                                  )
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: state.transaction['logs']['va_numbers']
                                          [0]['va_number']
                                      .toString(),
                                ),
                              );

                              const snackBar = SnackBar(
                                content: Text('Nomor VA Berhasil Disalin'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Text(
                              "Salin",
                              style: labelTextStyle.copyWith(
                                fontSize: 12,
                                color: greenColor,
                              ),
                            ),
                          )
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
                    state.transaction['status'] == "Menunggu Pembayaran" ||
                            state.transaction['status'] == "Kedaluwarsa"
                        ? Assets.icPending
                        : state.transaction['status'] == "Pengajuan Diproses"
                            ? Assets.icProcess
                            : state.transaction['status'] == "Terdaftar"
                                ? Assets.icSuccess
                                : Assets.icFail,
                    width: 234,
                    height: 38,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    state.transaction['status'],
                    style: regularTextStyle,
                  ),
                  Text(
                    'Terakhir diperbarui: ${Date.formatJam(state.transaction['updatedAt'])}, ${Date.formatTglIndo(state.transaction['updatedAt'])}',
                    style: regularTextStyle.copyWith(
                        fontSize: 10, color: const Color(0xFF94959B)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
