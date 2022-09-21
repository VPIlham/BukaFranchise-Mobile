import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bukafranchise/utils/assets.dart';

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _deskripsi, _harga, _kategori, valKategori;

  final roleKategori = ['Industri Makanan & Minuman', 'Industri Ritel'];

  final nameC = TextEditingController();
  final deskripsiC = TextEditingController();
  final hargaC = TextEditingController();

  @override
  void dispose() {
    nameC.dispose();
    deskripsiC.dispose();
    hargaC.dispose();
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
          "Tambah Produk",
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
                            hintText: 'Masukan Nama Produk',
                            filled: true,
                            contentPadding: const EdgeInsets.all(18),
                            fillColor: inputColorGray,
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nama Produk wajib diisi!';
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
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
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
                            hintStyle: const TextStyle(
                              height: 2.8,
                            ),
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
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: regularTextStyle,
                          controller: hargaC,
                          decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: 'Harga',
                            filled: true,
                            contentPadding: const EdgeInsets.all(18),
                            fillColor: inputColorGray,
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Harga wajib diisi!';
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            _harga = value;
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
                            style: regularTextStyle,
                            hint: Text(
                              "Kategori",
                              style: regularTextStyle,
                            ),
                            value: valKategori,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                            ),
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Kategori Wajib diisi!';
                              }
                              return null;
                            },
                            items: roleKategori.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                valKategori = value.toString();
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
                              'Tambah',
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
