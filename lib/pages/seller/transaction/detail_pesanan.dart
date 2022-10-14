import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bukafranchise/bloc/transaction/transaction_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailPesananPage extends StatefulWidget {
  final data;
  const DetailPesananPage({super.key, this.data});

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _pay, valPay, _status, valStatus;

  final rolePay = ['Cash', 'DP', 'Cicilan'];
  final dataStatus = ['Terdaftar', 'Dibatalkan'];

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    print('UBAH STATUS = $valStatus');
    print('DATA = ${widget.data}');

    context
        .read<TransactionCubit>()
        .updateTransaction(data: {"status": valStatus}, id: widget.data["id"]);
  }

  @override
  Widget build(BuildContext context) {
    // CASE STATUS PAYMENT
    if (widget.data['statusPayment'] == 'cash') {
      valPay = "Cash";
    } else if (widget.data['statusPayment'] == 'cicilan') {
      valPay = "Cicilan";
    } else if (widget.data['statusPayment'] == 'dp') {
      valPay = "DP";
    }

    //CASE STATUS
    final status = widget.data['status'];
    if (dataStatus.contains(status)) {
      valStatus = status;
    }

    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Detil Pesanan",
          style: titleTextStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          print("STATE DETAIL PESANAN $state");
          if (state.transactionStatus == TransactionStatus.formSuccess) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Sukses',
              desc: 'Status pesanan berhasil diubah',
              btnOkOnPress: () {
                Navigator.pop(context);
                context.read<TransactionCubit>().getListorderById(
                    sort: "createdAt", direction: "desc", pageSize: 40);
              },
            ).show();
          }
        },
        builder: (context, state) {
          var imgUrl = widget.data?["Item"]?["Upload"] != null
              ? "$URL_WEB${widget.data?["Item"]?["Upload"]["path"]}"
              : '';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data['trxId'],
                  style: titleTextStyle.copyWith(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          Date.formatTglIndo(widget.data['createdAt']),
                          style: regularTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 150,
                      height: 20,
                      decoration: BoxDecoration(
                        color: widget.data['status'] == "Terdaftar"
                            ? greenColor
                            : widget.data['status'] == "Pengajuan Diproses"
                                ? mainColor
                                : widget.data['status'] == "Menunggu Pembayaran"
                                    ? orangeColor
                                    : widget.data['status'] == "Dibatalkan"
                                        ? redColor
                                        : textDateGray,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          widget.data['status'],
                          style: labelTextStyle.copyWith(
                              color: widget.data['status'] == "Kedaluwarsa"
                                  ? greyColor
                                  : Colors.white,
                              letterSpacing: 1,
                              fontSize: 10),
                        ),
                      ),
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data['Item']['name'],
                                style: titleTextStyle.copyWith(
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                              // Text(
                              //   formatRupiah.format(
                              //       int.parse(widget.data['Item']['price'])),
                              //   style: regularTextStyle.copyWith(fontSize: 16),
                              // ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.icTag,
                                    height: 12,
                                    width: 9,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    widget.data['Item']['Brand']['category'],
                                    style:
                                        regularTextStyle.copyWith(fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pesanan",
                          style: labelTextStyle.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Nama",
                          style: regularTextStyle.copyWith(fontSize: 12),
                        ),
                        Text(
                          widget.data['User']['name'],
                          style: labelTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Email",
                          style: regularTextStyle.copyWith(fontSize: 12),
                        ),
                        Text(
                          widget.data['User']['email'],
                          style: labelTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Nomor Telp.",
                          style: regularTextStyle.copyWith(fontSize: 12),
                        ),
                        Text(
                          widget.data['User']['phoneNumber'] ?? '-',
                          style: labelTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Pembayaran",
                          style: regularTextStyle.copyWith(fontSize: 12),
                        ),
                        Text(
                          widget.data['statusPayment'] == 'dp'
                              ? "Uang Muka"
                              : widget.data['statusPayment'] == 'cash'
                                  ? "Tunai"
                                  : "Cicilan",
                          style: labelTextStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 24,
                ),
                status == "Pengajuan Diproses"
                    ? Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: inputColorGray,
                          ),
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            hint: const Text("Status Pesanan"),
                            value: valStatus,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                            ),
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Status Pesanan Wajib diisi!';
                              }
                              return null;
                            },
                            items: dataStatus.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                            onSaved: (value) {
                              valStatus = value;
                            },
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 60,
                ),
                status == "Pengajuan Diproses"
                    ? InkWell(
                        onTap: () {
                          if (state.transactionStatus !=
                              TransactionStatus.submitting) {
                            _submit();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: (state.transactionStatus ==
                                    TransactionStatus.submitting)
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Simpan',
                                    style: labelTextStyle.copyWith(
                                        color: Colors.white, letterSpacing: 1),
                                  ),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}
