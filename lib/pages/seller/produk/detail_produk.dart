import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bukafranchise/bloc/product/product_cubit.dart';
import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DetailProduk extends StatefulWidget {
  final String productId;
  const DetailProduk({super.key, required this.productId});

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _deskripsi, _harga, _kategori;

  final dataKategori = [
    'Industri Makanan & Minuman',
    'Industri Ritel',
    'Industri Kecantikan & Kesehatan',
    'Industri Pendidikan Non Formal'
  ];

  File? image;
  bool isSelected = false;
  bool isDelete = false;
  bool isImgError = false;
  final ImagePicker _picker = ImagePicker();

  void clickImg() async {
    final XFile? imgPicker = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (imgPicker != null) {
      setState(() {
        image = File(imgPicker.path);
        isImgError = false;
        isSelected = true;
      });
    }
  }

  var nameC = TextEditingController();
  var deskripsiC = TextEditingController();
  var hargaC = TextEditingController();

  @override
  void dispose() {
    nameC.dispose();
    deskripsiC.dispose();
    hargaC.dispose();
    super.dispose();
  }

  void getMyProduct() {
    context.read<ProductCubit>().getProductId(id: widget.productId);
  }

  @override
  void initState() {
    getMyProduct();
    super.initState();
  }

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      if (image == null) {
        setState(() {
          isImgError = true;
        });
      }
      return;
    }

    form.save();

    final brandId = await getBrandId();
    final userId = await getUserId();

    final Map<String, dynamic> data = {
      "name": _name,
      "price": int.parse(_harga!),
      "description": _deskripsi,
      "BrandId": int.parse(brandId!),
      "UserId": int.parse(userId!),
    };

    context
        .read<ProductCubit>()
        .updateProduct(data: data, image: image, id: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
          context: context,
          title: Text(
            "Edit Produk",
            style: titleTextStyle,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.topSlide,
                    title: 'Hapus Data',
                    desc: 'Anda yakin ingin menghapus data ini ?',
                    btnOkOnPress: () {
                      setState(() {
                        isDelete = true;
                      });
                      context
                          .read<ProductCubit>()
                          .deleteProduct(id: widget.productId);
                    },
                    btnCancelText: 'Tidak',
                    btnOkText: 'Ya',
                    btnCancelOnPress: () {},
                  ).show();
                },
              ),
            ),
          ]),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state.productStatus == ProductStatus.formSuccess) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Sukses',
              desc: 'Edit Produk berhasil dirubah!',
              btnOkOnPress: () {
                context.read<ProductCubit>().getMyProduct();
                Navigator.pop(context);
              },
            ).show();
          }
          if (state.productStatus == ProductStatus.formSuccess && isDelete) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Sukses',
              desc: 'Data telah terhapus!',
              btnOkOnPress: () {
                context.read<ProductCubit>().getMyProduct();
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ).show();
          }
          if (state.productStatus == ProductStatus.error) {
            if (image == null) {
              setState(() {
                isImgError = true;
              });
            }
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.topSlide,
              title: 'Gagal',
              desc: 'Edit Produk Gagal!',
              btnOkOnPress: () {},
            ).show();
          }
        },
        builder: (context, state) {
          if (state.productStatus == ProductStatus.loaded) {
            _name = state.product['name'];
            _deskripsi = state.product['description'];
            _harga = state.product['price'];
            _kategori = state.product['Brand']['category'];

            nameC = TextEditingController(text: _name);
            hargaC = TextEditingController(text: _harga.toString());
            deskripsiC = TextEditingController(text: _deskripsi.toString());
          }

          if (state.productStatus == ProductStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final imgServer = "$URL_WEB${state.product['Upload']['path']}";
          print('my IMAGE = $imgServer');

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
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            onTap: clickImg,
                            child: state.product['Upload'] != ''
                                ? isSelected
                                    ? CircleAvatar(
                                        radius: 70,
                                        backgroundImage: FileImage(image!),
                                      )
                                    : CircleAvatar(
                                        radius: 70,
                                        foregroundColor: Colors.transparent,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          imageUrl: imgServer,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      )
                                : isSelected
                                    ? CircleAvatar(
                                        radius: 70,
                                        foregroundColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: Image.file(
                                            image!,
                                            width: 135,
                                            height: 121,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 70,
                                        foregroundColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: Image.asset(
                                            Assets.logoAvatar,
                                            width: 135,
                                            height: 121,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                          ),
                          isImgError
                              ? Text(
                                  'Image wajib diisi!',
                                  style: regularTextStyle.copyWith(
                                      color: Colors.red),
                                )
                              : const SizedBox()
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
                              maxLines: 5,
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
                                value: _kategori,
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
                                items: dataKategori.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _kategori = value.toString();
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 33,
                            ),
                            InkWell(
                              onTap: state.productStatus ==
                                      ProductStatus.submitting
                                  ? null
                                  : _submit,
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: state.productStatus ==
                                          ProductStatus.submitting
                                      ? Colors.grey
                                      : mainColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                    child: Text(
                                  state.productStatus ==
                                          ProductStatus.submitting
                                      ? 'Loading...'
                                      : 'Edit Produk',
                                  style: labelTextStyle.copyWith(
                                      color: Colors.white, letterSpacing: 1),
                                )),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
