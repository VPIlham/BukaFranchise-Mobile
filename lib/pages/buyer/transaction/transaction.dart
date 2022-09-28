import 'package:bukafranchise/bloc/transaction/transaction_cubit.dart';
import 'package:bukafranchise/pages/buyer/transaction/detail_pesanan.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final searchController = TextEditingController();

  void getListTrasaction() {
    context.read<TransactionCubit>().getListorderById();
  }

  @override
  void initState() {
    getListTrasaction();
    super.initState();
  }

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
      body: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state.transactions);
          if (state.transactionStatus == TransactionStatus.loading) {
            return const Center(
              child: LoadingTransaction(),
            );
          }
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 24, left: 24, bottom: 12),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: regularTextStyle,
                            controller: searchController,
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
                              hintStyle: regularTextStyle,
                              filled: true,
                              fillColor: inputColorGray,
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                    itemCount: state.transactions.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
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
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
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
                                                      ['price']),
                                              style: regularTextStyle.copyWith(
                                                fontSize: 10,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 150,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: mainColor,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  state.transactions[index]
                                                      ['status'],
                                                  style:
                                                      labelTextStyle.copyWith(
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
                          ),
                        ),
                      );
                    },
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
