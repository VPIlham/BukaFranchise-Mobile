import 'dart:io';
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PengaturanAkun extends StatefulWidget {
  const PengaturanAkun({super.key});

  @override
  State<PengaturanAkun> createState() => _PengaturanAkunState();
}

class _PengaturanAkunState extends State<PengaturanAkun> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String? _name, _telp, _password;
  bool _isObscure = true;

  File? image;
  bool isSelected = false;

  var nameC = TextEditingController();
  var telpC = TextEditingController();
  var passwordC = TextEditingController();

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
        isSelected = true;
      });
      print('MY IMAGE $image');
    }
  }

  Future<void> getLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      //
    } else {}
  }

  @override
  void dispose() {
    nameC.dispose();
    telpC.dispose();
    passwordC.dispose();
    getLostData();
    super.dispose();
  }

  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  void _getProfile() async {
    final id = await getUserId();
    context.read<ProfileCubit>().getProfile(id: id);
  }

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final id = await getUserId();

    form.save();

    context.read<ProfileCubit>().updateProfile(
          id: id,
          name: _name,
          phoneNumber: _telp,
          image: image,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar.build(
        context: context,
        title: Text(
          "Pengaturan Akun",
          style: titleTextStyle,
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ProfileStatus.formSuccess) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Sukses',
              desc: 'Edit Profile berhasil dirubah!',
              btnOkOnPress: () {
                _getProfile();
                Navigator.pop(context);
              },
            ).show();
          }
          if (state.profileStatus == ProfileStatus.error) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.topSlide,
              title: 'Gagal',
              desc: 'Edit Profile Gagal!',
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          }
        },
        buildWhen: (context, state) {
          print('STATE AKUN = ${state.profileStatus}');
          if (state.profileStatus == ProfileStatus.loaded) {
            _name = state.user.name!;
            _password = state.user.password ?? '';
            _telp = state.user.phoneNumber ?? '';

            nameC = TextEditingController(text: _name);
            telpC = TextEditingController(text: _telp.toString());

            return true;
          }
          return false;
        },
        builder: (context, state) {
          print('STATE PROFILE = $state');
          final imgServer = "$URL_WEB${state.user.image}";
          print(imgServer);
          if (state.profileStatus == ProfileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.profileStatus == ProfileStatus.loaded &&
              _name != null) {
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
                              child: state.user.image != ''
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
                                            errorWidget:
                                                (context, url, error) =>
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
                                  hintText: 'Masukan Nama Lengkap',
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(18),
                                  fillColor: inputColorGray,
                                ),
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Nama wajib diisi!';
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
                              // TextFormField(
                              //   obscureText: _isObscure,
                              //   controller: passwordC,
                              //   keyboardType: TextInputType.visiblePassword,
                              //   style: regularTextStyle,
                              //   decoration: InputDecoration(
                              //     disabledBorder: InputBorder.none,
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(10.0),
                              //       borderSide: const BorderSide(
                              //         width: 0,
                              //         style: BorderStyle.none,
                              //       ),
                              //     ),
                              //     hintText: 'Ubah password',
                              //     filled: true,
                              //     fillColor: inputColorGray,
                              //     suffixIcon: IconButton(
                              //       icon: Icon(
                              //         _isObscure
                              //             ? Icons.visibility
                              //             : Icons.visibility_off,
                              //       ),
                              //       onPressed: () {
                              //         setState(() {
                              //           _isObscure = !_isObscure;
                              //         });
                              //       },
                              //     ),
                              //   ),
                              //   validator: (String? value) {
                              //     if (value == null || value.trim().isEmpty) {
                              //       return 'Password wajib diisi!';
                              //     }

                              //     if (value.trim().length < 6) {
                              //       return 'Password harus lebih dari 6 karakter!';
                              //     }
                              //     return null;
                              //   },
                              //   onSaved: (String? value) {
                              //     _password = value;
                              //   },
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                style: regularTextStyle,
                                controller: telpC,
                                decoration: InputDecoration(
                                  disabledBorder: InputBorder.none,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  hintText: 'Masukan Nomor Telepon',
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(18),
                                  fillColor: inputColorGray,
                                ),
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Nomor Telepon wajib diisi!';
                                  }

                                  return null;
                                },
                                onSaved: (String? value) {
                                  _telp = value;
                                },
                              ),
                              const SizedBox(
                                height: 33,
                              ),
                              InkWell(
                                onTap: state.profileStatus ==
                                        ProfileStatus.submitting
                                    ? null
                                    : _submit,
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: state.profileStatus ==
                                            ProfileStatus.submitting
                                        ? Colors.grey
                                        : mainColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                      child: Text(
                                    state.profileStatus ==
                                            ProfileStatus.submitting
                                        ? 'Loading...'
                                        : 'Ubah Profile',
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
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
