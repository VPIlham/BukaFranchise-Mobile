import 'package:flutter/material.dart';
import 'package:bukafranchise/bloc/register/register_cubit.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:validators/validators.dart';
import 'package:bukafranchise/utils/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email,
      _name,
      _role,
      _password,
      _namaBrand,
      _startOperation,
      _category,
      _totalEmployee;

  bool _isObscure = true;

  bool _validasiStartOperation = false;

  final roleData = ['buyer', 'seller'];
  final categoryData = [
    'Industri Makanan & Minuman',
    'Industri Ritel',
    'Industri Kecantikan & Kesehatan',
    'Industri Pendidikan Non Formal'
  ];

  final nameC = TextEditingController();
  final nameBrandC = TextEditingController();
  final startOperationC = TextEditingController();
  final totalKaryawanC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    nameBrandC.dispose();
    startOperationC.dispose();
    totalKaryawanC.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      if (_startOperation == null && _role == 'seller') {
        _validasiStartOperation = true;
      } else {
        _validasiStartOperation = false;
      }
      return;
    }

    form.save();

    context.read<RegisterCubit>().register(
          email: _email!,
          password: _password!,
          name: _name!,
          role: _role!,
          nameBrand: _namaBrand ?? '',
          totalEmployee:
              _totalEmployee == null ? 0 : int.parse(_totalEmployee!),
          categoryBrand: _category ?? '',
          startOperation: _startOperation ?? '',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.registerStatus == RegisterStatus.success) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Pendaftaran Sukses',
              desc: 'Silakan login terlebih dahulu!',
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          }
          if (state.registerStatus == RegisterStatus.error) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.topSlide,
              title: 'Gagal',
              desc: 'Sepertinya email Anda sudah terdaftar!',
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Image.asset(
                  Assets.logoShape,
                  height: 85,
                ),
                ListView(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    //Header
                    Column(
                      children: [
                        Text(
                          'Daftar',
                          style: labelTextStyle.copyWith(
                              letterSpacing: 1, fontSize: 22),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              'Daftar dan Temukan Usahamu',
                              style: labelTextStyle.copyWith(
                                fontSize: 14,
                                letterSpacing: 1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Buka',
                                  style: labelTextStyle.copyWith(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  'Franchise ',
                                  style: labelTextStyle.copyWith(
                                    color: mainColor,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'tanpa ribet',
                                  style: labelTextStyle.copyWith(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //Form
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                hintText: 'Masukan nama',
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
                              keyboardType: TextInputType.emailAddress,
                              style: regularTextStyle,
                              controller: emailC,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Masukan email',
                                filled: true,
                                contentPadding: const EdgeInsets.all(18),
                                fillColor: inputColorGray,
                              ),
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Email wajib diisi!';
                                }

                                if (!isEmail(value.trim())) {
                                  return 'Masukan email yang benar!';
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                _email = value;
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
                                hintText: 'Masukan password',
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
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: inputColorGray,
                              ),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                hint: const Text("Daftar Sebagai"),
                                value: _role,
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.all(18),
                                ),
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Role wajib diisi!';
                                  }
                                  return null;
                                },
                                items: roleData.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.toString().toTitleCase()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _role = value.toString();
                                  });
                                },
                              ),
                            ),
                            _role == 'seller'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.name,
                                        style: regularTextStyle,
                                        controller: nameBrandC,
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
                                          hintText: 'Masukan nama brand',
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(18),
                                          fillColor: inputColorGray,
                                        ),
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Nama Brand wajib diisi!';
                                          }

                                          return null;
                                        },
                                        onSaved: (String? value) {
                                          _namaBrand = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        style: regularTextStyle,
                                        controller: totalKaryawanC,
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
                                          hintText: 'Masukan total karyawan',
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(18),
                                          fillColor: inputColorGray,
                                        ),
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Total Karyawan wajib diisi!';
                                          }

                                          if (!isNumeric(value)) {
                                            return 'Wajib bertipe number!';
                                          }

                                          return null;
                                        },
                                        onSaved: (String? value) {
                                          _totalEmployee = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: inputColorGray,
                                        ),
                                        child: DropdownButtonFormField(
                                          isExpanded: true,
                                          hint: const Text("Kategori"),
                                          value: _category,
                                          decoration: const InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.all(18),
                                          ),
                                          validator: (value) {
                                            if (value == null || value == '') {
                                              return 'Kategori wajib diisi!';
                                            }
                                            return null;
                                          },
                                          items: categoryData.map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value
                                                  .toString()
                                                  .toTitleCase()),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _category = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime(1950, 1, 1),
                                              maxTime: DateTime.now(),
                                              onChanged: (date) {},
                                              onConfirm: (date) {
                                            setState(() {
                                              _startOperation = date.toString();
                                              startOperationC.text =
                                                  Date.formatTglIndo(
                                                      _startOperation
                                                          .toString());

                                              _validasiStartOperation = false;
                                            });
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.id);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _startOperation != null
                                                ? TextFormField(
                                                    controller: startOperationC,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: inputColorGray,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            _startOperation != null
                                                ? const SizedBox(height: 10)
                                                : const SizedBox(),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: const Center(
                                                child: Text(
                                                  'Tanggal Berdiri Brand',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                            //Jarak error
                                            _validasiStartOperation == true
                                                ? const SizedBox(
                                                    height: 6,
                                                  )
                                                : const SizedBox(),
                                            _validasiStartOperation == true
                                                ? const Text(
                                                    'Tanggal berdiri brand wajib diisi!',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  )
                                : const SizedBox(height: 35),
                            InkWell(
                              onTap: state.registerStatus ==
                                      RegisterStatus.submitting
                                  ? null
                                  : _submit,
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: state.registerStatus ==
                                          RegisterStatus.submitting
                                      ? Colors.grey
                                      : mainColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    state.registerStatus ==
                                            RegisterStatus.submitting
                                        ? 'Loading...'
                                        : 'Daftar',
                                    style: labelTextStyle.copyWith(
                                        color: Colors.white, letterSpacing: 1),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sudah memiliki akun ? ',
                                  style: labelTextStyle,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'masuk',
                                    style: labelTextStyle.copyWith(
                                        color: greenColor),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
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
