import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

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
    super.dispose();
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    // context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Pencairan",
          style: titleTextStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                //Header
                Center(
                  child: Column(
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
                        'Rp35.000.000',
                        style: titleTextStyle.copyWith(
                          fontSize: 32,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      // FORM
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: _autovalidateMode,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                style: regularTextStyle,
                                controller: jumlahC,
                                decoration: InputDecoration(
                                  disabledBorder: InputBorder.none,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  hintText: 'Masukan Jumlah Nominal',
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(18),
                                  fillColor: inputColorGray,
                                ),
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Cairkan',
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Riwayat Pencarian',
                        style: titleTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
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
                                          'Penarikan #212312312312',
                                          style: labelTextStyle.copyWith(
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Rp. 30000',
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
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
