// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:diploma_citizen/data/models/user_model.dart';
import 'package:diploma_citizen/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:diploma_citizen/data/constants/textStyles.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/sized_boxes.dart';
import '../../components/list_data/alert_choose_city.dart';
import '../auth_bloc/auth_bloc.dart';

TextEditingController iinController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController midNameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
int _cityId = -1;
String? _choosedCity;
var maskFormatter = MaskTextInputFormatter(
    mask: '+# ### ###-##-##', filter: {"#": RegExp(r'[0-9]')});
bool _canGo = false;
bool _isFocused = false;
// GlobalKey<ScaffoldState> _key = GlobalKey();

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isFocused = false;
    });
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
            // key: _key,
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            // floatingActionButton: _isFocused ? SizedBox() : float_button(),
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    sb_h16(),
                    Text(
                      'Registration',
                      style: ts0c_24_400,
                    ),
                    sb_h16(),
                    all_inputs_body(),
                    state is AuthFailure
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: 20,
                            alignment: Alignment.center,
                            child: Text(
                              'ERROR',
                              style: tsred_12_500,
                            ),
                          )
                        : SizedBox(),
                    sb_h10(),
                    float_button(state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Padding all_inputs_body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Firstname*',
            style: ts0c_12_500,
          ),
          names_input('Enter firstname', firstNameController),
          Text(
            'Lastname*',
            style: ts0c_12_500,
          ),
          names_input('Enter lastname', lastNameController),
          Text(
            'Midname',
            style: ts0c_12_500,
          ),
          names_input('Enter midname', midNameController),
          Text(
            'IIN*',
            style: ts0c_12_500,
          ),
          iin_input(),
          Text(
            'Phone number',
            style: ts0c_12_500,
          ),
          phone_input(),
          Text(
            'Password',
            style: ts0c_12_500,
          ),
          password_input(),
          Text(
            'City',
            style: ts0c_12_500,
          ),
          choose_city(),
          sb_h10(),
          Text(
            'Address',
            style: ts0c_12_500,
          ),
          names_input('Enter address', addressController),
          Text(
            'Street, house',
            style: tsgr_12_400,
          ),
        ],
      ),
    );
  }

  // Widget bottomSheetBody(Function stcityId) {
  //   return DraggableScrollableSheet(
  //     initialChildSize: 0.4,
  //     snap: true,
  //     builder: (BuildContext context, ScrollController scrollController) {
  //       return ListCitiesBody(
  //         stcityId: stcityId,
  //         scrollController: scrollController,
  //         isCategory: false,
  //         isCity: true,
  //       );
  //     },
  //   );
  // }

  GestureDetector float_button(AuthState state) {
    return GestureDetector(
      onTap: () {
        _canGo && state is! AuthLoading
            ? context.read<AuthBloc>().add(
                  RegisterEvent(
                    userModel: RegistrationUserModel(
                      iin: iinController.text,
                      password: passwordController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      middleName: midNameController.text,
                      phoneNumber: phoneController.text
                          .replaceAll(' ', '')
                          .replaceAll('-', ''),
                      // cityName: citiesList[_cityId],
                      cityName: _choosedCity!,
                      address: addressController.text,
                    ),
                  ),
                )
            : null;
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        // height: 44,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 10),
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
                'Register',
                style: tsgr_12_400,
              ),
      ),
    );
  }

  Widget choose_city() {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   _cityId = 0;
        // });
        checkGo();
        unFocus();
        // _key.currentState!.showBottomSheet(
        //   // context: context,
        //   (context) {
        //     // return bottomSheetBody((int index) {
        //     //   setState(() {
        //     //     _cityId = index;
        //     //   });
        //     // });
        //     return DraggableScrollableSheet(
        //       initialChildSize: 0.4,
        //       snap: true,
        //       builder:
        //           (BuildContext context, ScrollController scrollController) {
        //         return ListDataBody(
        //           stcityId: (String cityName) {
        //             setState(() {
        //               // _cityId = index;
        //               _choosedCity = cityName;
        //             });
        //           },
        //           scrollController: scrollController,
        //           isCity: true,
        //           close: () {},
        //           title: 'Choose city',
        //           cityName: '',
        //         );
        //       },
        //     );
        //   },
        //   backgroundColor: Colors.transparent,
        // );
        showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) =>
              AlertSetRegionCity(
            stcityId: (String cityName) {
              setState(() {
                // _cityId = index;
                _choosedCity = cityName;
              });
            },
            isCity: true,
            close: () {},
            title: 'Choose city',
            cityName: '',
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: greyA8,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              // _cityId != -1 ? citiesList[_cityId] : 'Choose city',
              _choosedCity != null ? _choosedCity! : 'Choose city',
              // style: _cityId != -1 ? ts0c_14_600 : tsgr_14_400,
              style: _choosedCity != null ? ts0c_14_400 : tsgr_14_400,
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_down,
              color: greyA8,
            ),
          ],
        ),
      ),
    );
  }

  Container names_input(String hintText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        textInputAction: TextInputAction.next,
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          counter: SizedBox(),
          hintText: hintText,
          hintStyle: tsgr_14_400,
          // contentPadding: EdgeInsets.all(0),
          contentPadding:
              EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: greyA8),
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

  Container phone_input() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        textInputAction: TextInputAction.next,
        controller: phoneController,
        inputFormatters: [maskFormatter],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: greyA8),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: blue),
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: '+7 (_ _ _) -_ _ _ - _ _ - _ _',
          hintStyle: tsgr_14_400,
          contentPadding:
              EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          errorStyle: tsred_12_500,
        ),
        // onTap: () {
        //   setState(() {
        //     _isFocused = true;
        //   });
        // },
        onChanged: (value) {
          checkGo();
        },
      ),
    );
  }

  Container password_input() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        textInputAction: TextInputAction.next,
        controller: passwordController,
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
            borderSide: const BorderSide(width: 1, color: greyA8),
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
        controller: iinController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Enter IIN',
          hintStyle: tsgr_14_400,
          // contentPadding: EdgeInsets.all(0),
          contentPadding:
              EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: greyA8),
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
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        // onEditingComplete: () => setState(() {
        //   isFormsActive = false;
        // }),
      ),
    );
  }

  void checkGo() {
    if (iinController.text.isNotEmpty &&
        iinController.text.length == 12 &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        // _cityId != -1) {
        _choosedCity != null) {
      setState(() {
        _canGo = true;
      });
    } else {
      setState(() {
        _canGo = false;
      });
    }
  }
}
 // return Container(
        //   margin: EdgeInsets.only(top: AppBar().preferredSize.height - 20),
        //   padding: EdgeInsets.all(12),
        //   height: MediaQuery.of(context).size.height -
        //       AppBar().preferredSize.height +
        //       20,
        //   decoration: BoxDecoration(
        //     color: white,
        //     borderRadius: BorderRadius.vertical(
        //       top: Radius.circular(16),
        //     ),
        //   ),
        //   child: SingleChildScrollView(
        //     controller: scrollController,
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               'Choose city',
        //               style: ts0c_16_500,
        //             ),
        //             GestureDetector(
        //               onTap: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   color: greyA8,
        //                   shape: BoxShape.circle,
        //                 ),
        //                 child: Icon(
        //                   Icons.close,
        //                   color: white,
        //                   size: 20,
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //         sb_h10(),
        //         SingleChildScrollView(
        //           child: Column(
        //             children: List.generate(
        //               20,
        //               (index) => GestureDetector(
        //                 onTap: () {
        //                   stcityId(index);
        //                 },
        //                 child: Container(
        //                   color: _cityId != index ? whitef3 : blueD3,
        //                   margin: EdgeInsets.symmetric(vertical: 1),
        //                   padding: EdgeInsets.symmetric(
        //                       horizontal: 16, vertical: 12),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(
        //                         '$index',
        //                         style: _cityId != index
        //                             ? tsgr_12_400
        //                             : tsbl_12_600,
        //                       ),
        //                       _cityId == index
        //                           ? Icon(
        //                               Icons.check,
        //                               color: blue,
        //                             )
        //                           : SizedBox(),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         // ListView.builder(
        //         //   controller: scrollController,
        //         //   itemCount: 25,
        //         //   itemBuilder: (BuildContext context, int index) {
        //         //     return ListTile(
        //         //       title: Text('Item $index'),
        //         //       onTap: () {
        //         //         stcityId(index);
        //         //       },
        //         //     );
        //         //   },
        //         // ),
        //       ],
        //     ),
        //   ),
        // );