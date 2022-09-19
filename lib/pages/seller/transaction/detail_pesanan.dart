import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailPesananPage extends StatefulWidget {
  const DetailPesananPage({super.key});

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _pay, valPay, _status, valStatus;

  final rolePay = ['Cash', 'DP', 'Cicilan'];
  final roleStatus = ['Pengajuan diproses', 'Terdaftar', 'Dibatalkan'];

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
          "Detil",
          style: titleTextStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '#22231341',
                        style: titleTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'April 17, 2017',
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
                      color: blueColor,
                      borderRadius: BorderRadius.circular(16),
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
                            'Paket 1 Geprek Bensu',
                            style: titleTextStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            'Rp22.000.000',
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
                                ' Industri Makanan & Minuman',
                                style: regularTextStyle.copyWith(fontSize: 10),
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: inputColorGray,
                ),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  hint: const Text("Pembayaran"),
                  value: valPay,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(18),
                  ),
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Pembayaran Wajib diisi!';
                    }
                    return null;
                  },
                  items: rolePay.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valPay = value.toString();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
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
                  items: roleStatus.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valStatus = value.toString();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                      child: Text(
                    'Simpan',
                    style: labelTextStyle.copyWith(
                        color: Colors.white, letterSpacing: 1),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
