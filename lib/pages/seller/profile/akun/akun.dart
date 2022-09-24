import 'package:bukafranchise/bloc/profile/profile_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:bukafranchise/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PengaturanAkun extends StatefulWidget {
  const PengaturanAkun({super.key});

  @override
  State<PengaturanAkun> createState() => _PengaturanAkunState();
}

class _PengaturanAkunState extends State<PengaturanAkun> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _telp, _password, _rekening, _bank, valBank;
  bool _isObscure = true;

  final roleBank = ['BCA', 'BRI'];

  final nameC = TextEditingController();
  final telpC = TextEditingController();
  final passwordC = TextEditingController();
  final rekeningC = TextEditingController();

  @override
  void dispose() {
    nameC.dispose();
    telpC.dispose();
    passwordC.dispose();
    rekeningC.dispose();
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
  void initState() {
    _getProfile();
    super.initState();
  }

  void _getProfile() async {
    final id = await getUserId();
    context.read<ProfileCubit>().getProfile(id: id);
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
          // TODO: implement listener
        },
        builder: (context, state) {
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
                            TextFormField(
                              obscureText: _isObscure,
                              controller: passwordC,
                              keyboardType: TextInputType.visiblePassword,
                              style: regularTextStyle,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Ubah password',
                                filled: true,
                                fillColor: inputColorGray,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Password wajib diisi!';
                                }

                                if (value.trim().length < 6) {
                                  return 'Password harus lebih dari 6 karakter!';
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                _password = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
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
                                hintText: 'Masukan Nomor Rekekning',
                                filled: true,
                                contentPadding: const EdgeInsets.all(18),
                                fillColor: inputColorGray,
                              ),
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Nomor Rekening wajib diisi!';
                                }

                                return null;
                              },
                              onSaved: (String? value) {
                                _rekening = value;
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
                                hint: const Text("Pilih Bank"),
                                value: valBank,
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.all(18),
                                ),
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Bank Wajib diisi!';
                                  }
                                  return null;
                                },
                                items: roleBank.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    valBank = value.toString();
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
                                  'Ubah Profile',
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
        },
      ),
    );
  }
}
