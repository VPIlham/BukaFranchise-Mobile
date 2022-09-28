import 'package:bukafranchise/pages/seller/transaction/detail_pesanan.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _filter, valFilter, _sort, valSort;

  final roleFilter = [
    'Pengajuan Diproses',
    'Terdaftar',
    'Dibatalkan',
    'Kadaluwarsa',
  ];
  final roleSort = [
    'Terbaru',
    'Terlama',
  ];

  final searchController = TextEditingController();

  @override
  void initState() {
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
      body: SafeArea(
        child: Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListView(
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // LoadingTransaction()
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const DetailPesananPage()));
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
                          offset:
                              const Offset(2, 3), // changes position of shadow
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '#3123123231222',
                                        style: regularTextStyle,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Kopi Kenangan Paket 2 (Kios + Starter Bahan Pertama)',
                                        style: labelTextStyle.copyWith(
                                            fontSize: 12),
                                      ),
                                      const SizedBox(
                                        height: 5,
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
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const DetailPesananPage()));
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
                          offset:
                              const Offset(2, 3), // changes position of shadow
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '#3123123231222',
                                        style: regularTextStyle,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Kopi Kenangan Paket 2 (Kios + Starter Bahan Pertama)',
                                        style: labelTextStyle.copyWith(
                                            fontSize: 12),
                                      ),
                                      const SizedBox(
                                        height: 5,
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: greenColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Terdaftar',
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
                ),
              ],
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
