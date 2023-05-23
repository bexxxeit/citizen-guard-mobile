// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:diploma_citizen/data/constants/assets.dart';
import 'package:diploma_citizen/data/constants/sized_boxes.dart';
import 'package:diploma_citizen/data/constants/textStyles.dart';
import 'package:diploma_citizen/screens/auth/other_pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/constants/colors.dart';
import '../home/home_page.dart';
import 'auth_bloc/auth_bloc.dart';

TextEditingController _iinController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

bool _canGo = false;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('tokenbox ${tokenBox.get('token')}');
    context.read<AuthBloc>().add(Emit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          });
        }
        return GestureDetector(
          onTap: () {
            unFocus();
          },
          child: Scaffold(
            backgroundColor: white,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Column(
                children: [
                  sb_h8(),
                  logo_body(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Spacer(),
                          Text(
                            'Log In',
                            style: ts0c_24_400,
                          ),
                          sb_h16(),
                          register(),
                          sb_h16(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username',
                                style: ts0c_12_500,
                              ),
                              sb_h4(),
                              iin_input(),
                              // sb_h16(),
                              Text(
                                'Password',
                                style: ts0c_12_500,
                              ),
                              sb_h4(),
                              password_input(),
                              button(state)
                            ],
                          ),
                          SizedBox(height: state is AuthFailure ? 50 : 100),
                          state is AuthFailure
                              ? AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  child: Container(
                                    height: 50,
                                    child: Text(
                                      'ERROR',
                                      style: tsred_12_500,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  GestureDetector button(AuthState state) {
    return GestureDetector(
      onTap: () {
        //dosth
        unFocus();
        _canGo && state is! AuthLoading
            ? context.read<AuthBloc>().add(LoginEvent(
                iin: _iinController.text, password: _passwordController.text))
            : null;
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _canGo ? blue : greyEF,
          borderRadius: BorderRadius.circular(12),
        ),
        child: state is AuthLoading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [CircularProgressIndicator()],
              )
            : Text(
                'Log In',
                style: tsgr_12_400,
              ),
      ),
    );
  }

  void checkGo() {
    if (_iinController.text.isNotEmpty &&
        _iinController.text.length == 12 &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _canGo = true;
      });
    } else {
      setState(() {
        _canGo = false;
      });
    }
  }

  Container password_input() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        controller: _passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          counter: SizedBox(),
          hintText: 'Enter password',
          hintStyle: tsgr_14_400,
          // contentPadding: EdgeInsets.all(0),
          contentPadding:
              EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xffA8A9BC)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: blue),
            borderRadius: BorderRadius.circular(15),
          ),

          alignLabelWithHint: true,
        ),
        onChanged: (value) {
          checkGo();
          // setState(() {
          //   isFormsActive = true;
          // });
        },
        // onEditingComplete: () => setState(() {
        //   isFormsActive = false;
        // }),
      ),
    );
  }

  Container iin_input() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        controller: _iinController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Enter IIN',
          hintStyle: tsgr_14_400,
          // contentPadding: EdgeInsets.all(0),
          contentPadding:
              EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xffA8A9BC)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: blue),
            borderRadius: BorderRadius.circular(15),
          ),
          counter: SizedBox(),
          alignLabelWithHint: true,
        ),
        maxLength: 12,
        onChanged: (value) {
          checkGo();
          // setState(() {
          //   isFormsActive = true;
          // });
        },
        // onEditingComplete: () => setState(() {
        //   isFormsActive = false;
        // }),
      ),
    );
  }

  Widget register() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return RegisterPage();
            },
          ),
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: ts0c_14_400,
          children: <TextSpan>[
            TextSpan(text: 'Don’t have an account? '),
            TextSpan(
              text: 'Register',
              style: tsbl_14_400_un,
            ),
          ],
        ),
      ),
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Text(
    //       'У меня есть аккаунт.',
    //       style: ts0c_14_400,
    //     ),
    //     SizedBox(width: 8),
    //     Text(
    //       'Зарегистрироваться',
    //       style: tsbl_14_400,
    //     ),
    //   ],
    // );
  }

  Row logo_body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(logo_image),
        ),
        sb_w8(),
        Text(
          'Citizen Guard',
          style: ts0c_16_600,
        ),
      ],
    );
  }

  void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
