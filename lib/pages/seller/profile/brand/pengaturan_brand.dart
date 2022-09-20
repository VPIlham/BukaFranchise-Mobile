import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bukafranchise/utils/assets.dart';

class PengaturanBrand extends StatefulWidget {
  const PengaturanBrand({super.key});

  @override
  State<PengaturanBrand> createState() => _PengaturanBrandState();
}

class _PengaturanBrandState extends State<PengaturanBrand> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _deskripsi, _total, _tanggal, _status, valStatus;

  final roleStatus = [
    'Pengajuan diproses, ',
    'Pengajuan dibatalkan',
    'Pengajuan ditolak',
    'Pengajuan berhasil'
  ];

  final nameC = TextEditingController();
  final deskripsiC = TextEditingController();
  final totalC = TextEditingController();
  final tanggalC = TextEditingController();
  final statusC = TextEditingController();

  @override
  void dispose() {
    nameC.dispose();
    deskripsiC.dispose();
    totalC.dispose();
    tanggalC.dispose();
    statusC.dispose();
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
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Pengaturan Brand",
          style: titleTextStyle,
        ),
      ),
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
                        height: 10,
                      ),
                      Image.asset(
                        Assets.logoUser,
                        width: 135,
                        height: 121,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
                //Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      children: [
                        // Nama Brand
                        TextFormField(
                          keyboardType: TextInputType.name,
                          style: regularTextStyle,
                          controller: nameC,
                          decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: 'Masukan Nama Brand',
                            filled: true,
                            contentPadding: const EdgeInsets.all(18),
                            fillColor: inputColorGray,
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nama Brand wajib diisi!';
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            _name = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Deskripsi
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: regularTextStyle,
                          controller: deskripsiC,
                          decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: 'Deskripsi',
                            filled: true,
                            contentPadding: const EdgeInsets.all(18),
                            fillColor: inputColorGray,
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Deskripsi wajib diisi!';
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            _deskripsi = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Total Karyawan
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: regularTextStyle,
                          controller: totalC,
                          decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: 'Masukan Total Karyawan',
                            filled: true,
                            contentPadding: const EdgeInsets.all(18),
                            fillColor: inputColorGray,
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Total Karyawan wajib diisi!';
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            _total = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Tanggal Berdiri
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: regularTextStyle,
                          controller: totalC,
                          decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: 'Masukan Total Karyawan',
                            filled: true,
                            contentPadding: const EdgeInsets.all(18),
                            fillColor: inputColorGray,
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Total Karyawan wajib diisi!';
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            _total = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
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
                          height: 33,
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
                            child: Center(
                                child: Text(
                              'Ubah Brand',
                              style: labelTextStyle.copyWith(
                                  color: Colors.white, letterSpacing: 1),
                            )),
                          ),
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
    );
  }
}
