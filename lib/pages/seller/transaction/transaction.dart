import 'dart:async';

import 'package:bukafranchise/bloc/transaction/transaction_cubit.dart';
import 'package:bukafranchise/pages/seller/transaction/detail_pesanan.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String? _filter, valFilter, _sort, valSort;

  final roleFilter = [
    'Semua',
    'Menunggu Pembayaran',
    'Pengajuan Diproses',
    'Terdaftar',
    'Dibatalkan',
    'Kedaluwarsa',
  ];

  final roleSort = [
    'Terbaru',
    'Terlama',
  ];

  final searchController = TextEditingController();
  Timer? _debounce;
  String? search;

  void getListTrasaction() {
    context
        .read<TransactionCubit>()
        .getListorderById(pageSize: 40, sort: "createdAt", direction: "desc");
  }

  @override
  void initState() {
    getListTrasaction();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future refreshPage() async {
    context
        .read<TransactionCubit>()
        .getListorderById(sort: "createdAt", direction: "desc", pageSize: 40);
  }

  _onSearchChanged(String query) {
    if (search != query) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        context.read<TransactionCubit>().getListorderById(
            search: query, sort: "createdAt", direction: "desc", pageSize: 40);
        setState(() {
          search = query;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Pesanan",
          style: titleTextStyle,
        ),
        leading: const Text(''),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 24, left: 24, bottom: 12),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: regularTextStyle,
                      controller: searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Cari Pesanan',
                        filled: true,
                        fillColor: inputColorGray,
                        suffixIcon: IconButton(
                          icon: Icon(
                            search == '' || search == null
                                ? Icons.search
                                : Icons.close_rounded,
                          ),
                          onPressed: () {
                            if (search != '' || search != null) {
                              context.read<TransactionCubit>().getListorderById(
                                  search: '',
                                  sort: "createdAt",
                                  direction: "desc",
                                  pageSize: 40);
                              setState(() {
                                search = '';
                              });
                              searchController.text = '';
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 24, left: 26, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: inputColorGray,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: DropdownButton<String>(
                            hint: Text(
                              "Filter status",
                              style: regularTextStyle,
                            ),
                            value: valFilter,
                            // value: null,

                            items: roleFilter.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                valFilter = value.toString();
                              });

                              if (valFilter == 'Pengajuan Diproses') {
                                context
                                    .read<TransactionCubit>()
                                    .getListorderById(
                                        status: 'Pengajuan Diproses');
                              } else if (valFilter == 'Menunggu Pembayaran') {
                                context
                                    .read<TransactionCubit>()
                                    .getListorderById(
                                        status: 'Menunggu Pembayaran');
                              } else if (valFilter == 'Terdaftar') {
                                context
                                    .read<TransactionCubit>()
                                    .getListorderById(status: 'Terdaftar');
                              } else if (valFilter == 'Dibatalkan') {
                                context
                                    .read<TransactionCubit>()
                                    .getListorderById(status: 'Dibatalkan');
                              } else if (valFilter == 'Kedaluwarsa') {
                                context
                                    .read<TransactionCubit>()
                                    .getListorderById(status: 'Kedaluwarsa');
                              } else {
                                context
                                    .read<TransactionCubit>()
                                    .getListorderById();
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: inputColorGray,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            hint: Text(
                              "Urutkan",
                              style: regularTextStyle,
                            ),
                            value: valSort,
                            // value: null,

                            items: roleSort.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                valSort = value.toString();
                              });

                              if (valSort == 'Terbaru') {
                                context
                                    .read<TransactionCubit>()
                                    .getListorderById(direction: 'desc');
                              } else if (valSort == 'Terlama') {
                                context
                                    .read<TransactionCubit>()
                                    .getListorderById(direction: 'asc');
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            BlocConsumer<TransactionCubit, TransactionState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                print(state.transactions);
                if (state.transactionStatus == TransactionStatus.loading) {
                  return const Expanded(
                    child: Center(
                      child: LoadingTransaction(),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: state.transactions.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      var imgUrl = state.transactions[index]["Item"]
                                  ["Upload"] !=
                              null
                          ? "$URL_WEB${state.transactions[index]["Item"]["Upload"]["path"]}"
                          : '';
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => DetailPesananPage(
                                        data: state.transactions[index],
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 15, top: 8, bottom: 10, right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    2, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Text(
                                        Date.formatTglIndo(state
                                            .transactions[index]['createdAt']),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          imageUrl: imgUrl,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            Assets.imgBrandPlaceholder,
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              state.transactions[index]
                                                  ['trxId'],
                                              style: regularTextStyle,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              state.transactions[index]['Item']
                                                  ['name'],
                                              style: labelTextStyle.copyWith(
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Pembayaran ${state.transactions[index]['statusPayment']}',
                                              style: labelTextStyle.copyWith(
                                                color: textDateGray,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              formatRupiah.format(
                                                  state.transactions[index]
                                                          ['price'] +
                                                      state.transactions[index]
                                                          ['fee']),
                                              style: regularTextStyle.copyWith(
                                                fontSize: 10,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              children: [
                                                if (state.transactions[index]
                                                        ['status'] ==
                                                    'Pengajuan Diproses') ...[
                                                  Container(
                                                    width: 150,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        state.transactions[
                                                            index]['status'],
                                                        style: labelTextStyle
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    1,
                                                                fontSize: 10),
                                                      ),
                                                    ),
                                                  ),
                                                ] else if (state
                                                            .transactions[index]
                                                        ['status'] ==
                                                    'Menunggu Pembayaran') ...[
                                                  Container(
                                                    width: 150,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: orangeColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        state.transactions[
                                                            index]['status'],
                                                        style: labelTextStyle
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    1,
                                                                fontSize: 10),
                                                      ),
                                                    ),
                                                  ),
                                                ] else if (state
                                                            .transactions[index]
                                                        ['status'] ==
                                                    'Dibatalkan') ...[
                                                  Container(
                                                    width: 100,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: redColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        state.transactions[
                                                            index]['status'],
                                                        style: labelTextStyle
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    1,
                                                                fontSize: 10),
                                                      ),
                                                    ),
                                                  ),
                                                ] else if (state
                                                            .transactions[index]
                                                        ['status'] ==
                                                    'Kedaluwarsa') ...[
                                                  Container(
                                                    width: 100,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: textDateGray,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        state.transactions[
                                                            index]['status'],
                                                        style: labelTextStyle
                                                            .copyWith(
                                                                color:
                                                                    greyColor,
                                                                letterSpacing:
                                                                    1,
                                                                fontSize: 10),
                                                      ),
                                                    ),
                                                  ),
                                                ] else if (state
                                                            .transactions[index]
                                                        ['status'] ==
                                                    'Terdaftar') ...[
                                                  Container(
                                                    width: 100,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: greenColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        state.transactions[
                                                            index]['status'],
                                                        style: labelTextStyle
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    1,
                                                                fontSize: 10),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingTransaction extends StatelessWidget {
  const LoadingTransaction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 110,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(color: Colors.white),
            child: SkeletonItem(
              child: Column(
                children: [
                  Row(
                    children: [
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.rectangle, width: 90, height: 90),
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
                                    MediaQuery.of(context).size.width / 1,
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
