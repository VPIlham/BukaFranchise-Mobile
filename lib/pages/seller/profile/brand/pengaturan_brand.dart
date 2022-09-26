import 'dart:io';

import 'package:bukafranchise/bloc/brand/brand_cubit.dart';
import 'package:bukafranchise/bloc/brand/brand_state.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PengaturanBrand extends StatefulWidget {
  const PengaturanBrand({super.key});

  @override
  State<PengaturanBrand> createState() => _PengaturanBrandState();
}

class _PengaturanBrandState extends State<PengaturanBrand> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String? _name,
      _description,
      _totalEmployees,
      _startOperation,
      _category,
      valKategori;

  File? _image;

  final roleKategori = [
    'Industri Makanan & Minuman',
    'Industri Ritel',
    'Industri Kecantikan & Kesehatan',
    'Industri Pendidikan Non Formal'
  ];

  late var nameC = TextEditingController();
  late var deskripsiC = TextEditingController();
  late var totalC = TextEditingController();
  late var tanggalC = TextEditingController();
  late var kategoriC = TextEditingController();

  @override
  void dispose() {
    nameC.dispose();
    deskripsiC.dispose();
    totalC.dispose();
    tanggalC.dispose();
    kategoriC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _getBrand();
    super.initState();
  }

  var id;

  void _getBrand() async {
    id = await getBrandId();
    context.read<BrandCubit>().getBrandId(id: int.parse(id));
  }

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    Map data = {
      "name": _name,
      "description": _description,
      "totalEmployees": _totalEmployees,
      "startOperation": _startOperation,
      "category": valKategori,
    };

    print("DATA UPDATE = $data");
    context.read<BrandCubit>().updateBrand(id: id, data: data, image: _image);
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
      body: BlocConsumer<BrandCubit, BrandState>(
        listener: (context, state) {
          if (state.brandStatus == BrandStatus.success) {
            var startOperation = DateTime.parse(state.brand["startOperation"]);
            String formattedDate =
                DateFormat('yyyy-MM-dd').format(startOperation);

            nameC = TextEditingController(text: state.brand["name"]);
            deskripsiC =
                TextEditingController(text: state.brand["description"]);
            tanggalC = TextEditingController(text: formattedDate);
            totalC = TextEditingController(
                text: state.brand["totalEmployees"].toString());
            setState(() {
              valKategori = state.brand["category"];
              _startOperation = formattedDate;
            });
          }
        },
        builder: (context, state) {
          print('STATE =  $state');
          if (state.brandStatus == BrandStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
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
                                _description = value;
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
                                _totalEmployees = value;
                              },
                            ),

                            // Tanggal Berdiri
                            Container(
                              padding: const EdgeInsets.all(18),
                              child: Center(
                                child: TextField(
                                  controller: tanggalC,
                                  //editing controller of this TextField
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.calendar_today),
                                    disabledBorder: InputBorder.none,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    hintText: 'Tanggal Berdiri',
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(18),
                                    fillColor: inputColorGray,
                                  ),
                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            DateTime.parse(tanggalC.text),
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime.now());

                                    if (pickedDate != null) {
                                      print('PICKED DATE = $pickedDate');
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        tanggalC.text =
                                            formattedDate; //set output date to TextField value.
                                        _startOperation = formattedDate;
                                      });
                                    } else {}
                                  },
                                ),
                              ),
                            ),
                            // Kategori
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
                            Column(
                              children: [
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
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SvgPicture.asset(Assets.icUpdate),
                                        Text(
                                          'Ubah Brand',
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
