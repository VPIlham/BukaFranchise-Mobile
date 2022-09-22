import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bukafranchise/bloc/auth/auth_bloc.dart';
import 'package:bukafranchise/bloc/login/login_cubit.dart';
import 'package:bukafranchise/pages/app_page.dart';
import 'package:bukafranchise/pages/register.dart';
import 'package:bukafranchise/repositories/auth_repository.dart';
import 'package:bukafranchise/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import 'package:bukafranchise/utils/assets.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;
  bool _isObscure = true;

  final emailC = TextEditingController(text: 'userbuyer@gmail.com');
  final passwordC = TextEditingController(text: 'test1234');

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

    context.read<LoginCubit>().login(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == AuthenticationStatus.error) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.topSlide,
              title: 'Gagal',
              desc: 'Email/Password Anda salah!',
              btnOkOnPress: () {},
            ).show();
          } else if (state.status == AuthenticationStatus.authenticated) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AppPage()));
          }
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
                            height: 40,
                          ),
                          Image.asset(
                            Assets.logo,
                            width: 298,
                            height: 80,
                          ),
                          const SizedBox(
                            height: 49,
                          ),
                          Text(
                            'Selamat datang di',
                            style: regularTextStyle.copyWith(
                              letterSpacing: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Buka',
                                style: regularTextStyle,
                              ),
                              Text('Franchise',
                                  style: regularTextStyle.copyWith(
                                      color: mainColor, letterSpacing: 1)),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            'MASUK',
                            style: titleTextStyle.copyWith(
                                fontSize: 22, letterSpacing: 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                              height: 33,
                            ),
                            InkWell(
                              onTap: state.status ==
                                      AuthenticationStatus.submitting
                                  ? null
                                  : _submit,
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: state.status ==
                                          AuthenticationStatus.submitting
                                      ? Colors.grey
                                      : mainColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                    child: Text(
                                  state.status ==
                                          AuthenticationStatus.submitting
                                      ? 'Loading...'
                                      : 'Masuk',
                                  style: labelTextStyle.copyWith(
                                      color: Colors.white, letterSpacing: 1),
                                )),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              'Atau',
                              style: labelTextStyle,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Daftar akun ',
                                  style:
                                      labelTextStyle.copyWith(letterSpacing: 1),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    state.status ==
                                            AuthenticationStatus.submitting
                                        ? null
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    const RegisterPage()));
                                  },
                                  child: Text(
                                    'sekarang',
                                    style: labelTextStyle.copyWith(
                                        color: greenColor),
                                  ),
                                ),
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
          );
        },
      ),
    );
  }
}
