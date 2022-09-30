import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/bloc/transaction/transaction_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:validators/sanitizers.dart';

class Pencairan extends StatefulWidget {
  const Pencairan({super.key});

  @override
  State<Pencairan> createState() => _PencairanState();
}

class _PencairanState extends State<Pencairan> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _jumlah;

  late var jumlahC = TextEditingController();

  @override
  void dispose() {
    jumlahC.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    context
        .read<TransactionCubit>()
        .createWithdraw(data: {"amount": toInt(_jumlah!)});
  }

  void _getListWithdraw() {
    context
        .read<TransactionCubit>()
        .getListWithdraw(pageSize: 40, sort: "createdAt", direction: "desc");
  }

  void _getProfile() async {
    final id = await getUserId();
    context.read<ProfileCubit>().getProfile(id: id);
  }

  Future onRefresh() async {
    final id = await getUserId();
    // ignore: use_build_context_synchronously
    context.read<ProfileCubit>().getProfile(id: id);
    // ignore: use_build_context_synchronously
    context
        .read<TransactionCubit>()
        .getListWithdraw(pageSize: 40, sort: "createdAt", direction: "desc");
  }

  @override
  void initState() {
    // TODO: implement initState
    _getListWithdraw();
    _getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Penarikan",
          style: titleTextStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              //Header
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 17,
                      ),
                      Text(
                        'Saldo Anda',
                        style: regularTextStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        formatRupiah.format(state.user.balance),
                        style: titleTextStyle.copyWith(
                          fontSize: 32,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      // FORM
                      BlocConsumer<TransactionCubit, TransactionState>(
                        listener: (context, state) {
                          if (state.transactionStatus ==
                              TransactionStatus.formSuccess) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.topSlide,
                              title: 'Sukses',
                              desc: 'Penarikan saldo berhasil dibuat',
                              btnOkOnPress: () {
                                _getProfile();
                                _getListWithdraw();
                              },
                            ).show();
                            jumlahC.clear();
                            setState(() {
                              _autovalidateMode = AutovalidateMode.disabled;
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                          }

                          if (state.transactionStatus ==
                              TransactionStatus.errorWithdraw) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.topSlide,
                              title: 'Gagal',
                              desc: state.errorMsg,
                              btnOkOnPress: () {},
                            ).show();

                            jumlahC.clear();
                            setState(() {
                              _autovalidateMode = AutovalidateMode.disabled;
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Form(
                              key: _formKey,
                              autovalidateMode: _autovalidateMode,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]'))
                                    ],
                                    style: regularTextStyle,
                                    controller: jumlahC,
                                    decoration: InputDecoration(
                                      disabledBorder: InputBorder.none,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      hintText: 'Masukan Jumlah Nominal',
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(18),
                                      fillColor: inputColorGray,
                                      prefixIcon: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 15, top: 14),
                                        child: Text('Rp'),
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Jumlah Nominal wajib diisi!';
                                      }

                                      return null;
                                    },
                                    onSaved: (String? value) {
                                      _jumlah = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  InkWell(
                                    onTap: _submit,
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Tarik Saldo',
                                            style: labelTextStyle.copyWith(
                                                color: Colors.white,
                                                letterSpacing: 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Riwayat Penarikan',
                  style: titleTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<TransactionCubit, TransactionState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state.transactionStatus == TransactionStatus.loading) {
                    return const loadingWithdrawHistory();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: state.withdraws.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
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
                                      Date.formatTglIndo(
                                          state.withdraws[index]['createdAt']),
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
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Penarikan #${state.withdraws[index]["trxId"]}',
                                            style: labelTextStyle.copyWith(
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            formatRupiah.format(toInt(state
                                                .withdraws[index]["amount"])),
                                            style: regularTextStyle.copyWith(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 150,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: state.withdraws[index]
                                                          ['status'] ==
                                                      "Berhasil"
                                                  ? greenColor
                                                  : state.withdraws[index]
                                                              ['status'] ==
                                                          "Pengajuan Diproses"
                                                      ? mainColor
                                                      : redColor,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Center(
                                              child: Text(
                                                state.withdraws[index]
                                                    ['status'],
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
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class loadingWithdrawHistory extends StatelessWidget {
  const loadingWithdrawHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(2, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 12,
                              width: 69,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 12,
                                    width: 130,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 10,
                                    width: 70,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 12,
                                    width: 130,
                                    borderRadius: BorderRadius.circular(8),
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
              ),
            );
          }),
    );
  }
}
