import 'package:bukafranchise/theme/style.dart';
import 'package:bukafranchise/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _name, valRole, _role, _password;
  bool _isObscure = true;

  final roleData = ['Buyer', 'Seller'];

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
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
      body: SafeArea(
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
                            hint: const Text("Role"),
                            value: valRole,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                            ),
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Role Wajib diisi!';
                              }
                              return null;
                            },
                            items: roleData.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                valRole = value.toString();
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 35),
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
                                'Daftar',
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
                                style:
                                    labelTextStyle.copyWith(color: greenColor),
                              ),
                            )
                          ],
                        )
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
