// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:diploma_citizen/data/constants/textStyles.dart';
import 'package:diploma_citizen/data/models/user_model.dart';
import 'package:diploma_citizen/screens/home/home_page.dart';

import '../../../data/constants/colors.dart';
import '../../../data/constants/sized_boxes.dart';
import '../components/list_data/alert_choose_city.dart';
import 'bloc/get_userprofile_bloc/get_userprofile_bloc.dart';

// TextEditingController _iinController = TextEditingController();
late TextEditingController _firstNameController;
late TextEditingController _lastNameController;
late TextEditingController _midNameController;
late TextEditingController _phoneController;
late TextEditingController _addressController;
String? _choosedCity;
var maskFormatter = MaskTextInputFormatter(
    mask: '+# ### ###-##-##', filter: {"#": RegExp(r'[0-9]')});
bool _canGo = false;
bool _isFocused = false;
// GlobalKey<ScaffoldState> _key = GlobalKey();

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetUserprofileBloc>().add(GetUserprofileEvent());
    // _lastNameController = TextEditingController(text: 'EXAMPLE');
  }

  void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isFocused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserprofileBloc, GetUserprofileState>(
      builder: (context, state) {
        if (state is SetUserprofileSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          });
        }
        if (state is GetUserprofileSuccess) {
          // _iinController.text = state.registrationUserModel.iin;
          // _firstNameController.text = state.registrationUserModel.firstName;
          // _lastNameController.text = state.registrationUserModel.lastName;
          // _midNameController.text = state.registrationUserModel.middleName;
          // _phoneController.text = state.registrationUserModel.phoneNumber;
          // _addressController.text = state.registrationUserModel.address;
          // _choosedCity = state.registrationUserModel.cityName;

          // _firstNameController = TextEditingController(
          //     text: state.registrationUserModel.firstName);
          // _lastNameController =
          //     TextEditingController(text: state.registrationUserModel.lastName);
          // _midNameController = TextEditingController(
          //     text: state.registrationUserModel.middleName);
          // _phoneController = TextEditingController(
          //     text: state.registrationUserModel.phoneNumber);
          // _addressController =
          //     TextEditingController(text: state.registrationUserModel.address);
          // _choosedCity = state.registrationUserModel.cityName;
        }
        return Scaffold(
          backgroundColor: white,
          body: state is GetUserprofileLoading
              ? SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width - 24,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                )
              : state is GetUserprofileSuccess
                  ? ForTextEditing(rum: state.registrationUserModel)
                  : state is GetUserprofileFailure
                      ? Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: Text(
                            'ERROR GET',
                            style: tsred_12_500,
                          ),
                        )
                      : state is SetUserprofileFailure
                          ? Container(
                              height: 100,
                              alignment: Alignment.center,
                              child: Text(
                                'ERROR SET',
                                style: tsred_12_500,
                              ),
                            )
                          : SizedBox(),
        );

        // GestureDetector(
        //   onTap: () {
        //     unFocus();
        //   },
        //   child: Scaffold(
        //     backgroundColor: white,
        //     key: _key,
        //     appBar: appBar(),
        //     floatingActionButtonLocation:
        //         FloatingActionButtonLocation.centerDocked,
        //     floatingActionButton: _isFocused ? SizedBox() : float_button(state),
        //     resizeToAvoidBottomInset: true,
        //     body: SafeArea(
        //       child: SingleChildScrollView(
        //         child: Column(
        //           children: [
        //             // sb_h16(),
        //             // Text(
        //             //   'Registration',
        //             //   style: ts0c_24_400,
        //             // ),
        //             sb_h16(),
        //             state is GetUserprofileLoading
        //                 ? SizedBox(
        //                     height: 300,
        //                     width: MediaQuery.of(context).size.width - 24,
        //                     child: Column(
        //                       mainAxisSize: MainAxisSize.min,
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [CircularProgressIndicator()],
        //                     ),
        //                   )
        //                 : state is GetUserprofileSuccess
        //                     ? all_inputs_body()
        //                     : state is GetUserprofileFailure
        //                         ? Container(
        //                             height: 100,
        //                             alignment: Alignment.center,
        //                             child: Text(
        //                               'ERROR',
        //                               style: tsred_12_500,
        //                             ),
        //                           )
        //                         : SizedBox(),
        //             state is SetUserprofileFailure
        //                 ? AnimatedContainer(
        //                     duration: Duration(milliseconds: 300),
        //                     height: 20,
        //                     alignment: Alignment.center,
        //                     child: Text(
        //                       'ERROR',
        //                       style: tsred_12_500,
        //                     ),
        //                   )
        //                 : SizedBox(),
        //             sb_h10(),
        //             // float_button(state),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: black0C,
        ),
      ),
      title: Text(
        'Edit profile',
        style: ts0c_24_400,
      ),
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
          names_input('Enter firstname', _firstNameController),
          Text(
            'Lastname*',
            style: ts0c_12_500,
          ),
          names_input('Enter lastname', _lastNameController),
          Text(
            'Midname',
            style: ts0c_12_500,
          ),
          names_input('Enter midname', _midNameController),
          // Text(
          //   'IIN*',
          //   style: ts0c_12_500,
          // ),
          // iin_input(),
          Text(
            'Phone number',
            style: ts0c_12_500,
          ),
          phone_input(),
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
          names_input('Enter address', _addressController),
          Text(
            'Street, house',
            style: tsgr_12_400,
          ),
        ],
      ),
    );
  }

  GestureDetector float_button(GetUserprofileState state) {
    return GestureDetector(
      onTap: () {
        _canGo && state is! GetUserprofileLoading
            ? context.read<GetUserprofileBloc>().add(
                  SetUserprofileEvent(
                    RegistrationUserModel(
                      iin: '_iinController.text',
                      password: ' passwordController.text',
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      middleName: _midNameController.text,
                      phoneNumber: _phoneController.text
                          .replaceAll(' ', '')
                          .replaceAll('-', ''),
                      // cityName: citiesList[_cityId],
                      cityName: _choosedCity!,
                      address: _addressController.text,
                    ),
                  ),
                )
            : null;
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        height: 44,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _canGo ? blue : greyEF,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Edit',
          style: tsgr_12_400,
        ),
      ),
    );
  }

  Widget choose_city() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFocused = true;
        });
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
        controller: _phoneController,
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

  // Container iin_input() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: white,
  //       borderRadius: BorderRadius.all(Radius.circular(16)),
  //     ),
  //     margin: EdgeInsets.symmetric(vertical: 12),
  //     child: TextFormField(
  //       textInputAction: TextInputAction.next,
  //       controller: _iinController,
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //         hintText: 'Enter IIN',
  //         hintStyle: tsgr_14_400,
  //         // contentPadding: EdgeInsets.all(0),
  //         contentPadding:
  //             EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
  //         border: OutlineInputBorder(
  //           borderSide: const BorderSide(width: 1, color: greyA8),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: const BorderSide(width: 1, color: blue),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         counter: SizedBox(),
  //         alignLabelWithHint: true,
  //       ),
  //       maxLength: 12,
  //       onChanged: (value) {
  //         checkGo();
  //         // setState(() {
  //         //   isFormsActive = true;
  //         // });
  //       },
  //       onTap: () {
  //         setState(() {
  //           _isFocused = true;
  //         });
  //       },
  //       // onEditingComplete: () => setState(() {
  //       //   isFormsActive = false;
  //       // }),
  //     ),
  //   );
  // }

  void checkGo() {
    if (
        //
        // _iinController.text.isNotEmpty &&
        //   _iinController.text.length == 12 &&
        _firstNameController.text.isNotEmpty &&
            _lastNameController.text.isNotEmpty &&
            _addressController.text.isNotEmpty &&
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

class ForTextEditing extends StatefulWidget {
  const ForTextEditing({
    Key? key,
    required this.rum,
  }) : super(key: key);
  final RegistrationUserModel rum;

  @override
  State<ForTextEditing> createState() => _ForTextEditingState();
}

class _ForTextEditingState extends State<ForTextEditing> {
  void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isFocused = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstNameController = TextEditingController(text: widget.rum.firstName);
    _lastNameController = TextEditingController(text: widget.rum.lastName);
    _midNameController = TextEditingController(text: widget.rum.middleName);
    _phoneController = TextEditingController(text: widget.rum.phoneNumber);
    _addressController = TextEditingController(text: widget.rum.address);
    _choosedCity = widget.rum.cityName;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus();
      },
      child: Scaffold(
        backgroundColor: white,
        // key: _key,
        appBar: appBar(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: _isFocused ? SizedBox() : float_button(),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // sb_h16(),
                      // Text(
                      //   'Registration',
                      //   style: ts0c_24_400,
                      // ),
                      sb_h16(),
                      all_inputs_body(),
                      sb_h10(),
                      // float_button(state),
                    ],
                  ),
                ),
              ),
              _isFocused ? SizedBox() : float_button(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: black0C,
        ),
      ),
      title: Text(
        'Edit profile',
        style: ts0c_24_400,
      ),
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
          names_input('Enter firstname', _firstNameController),
          Text(
            'Lastname*',
            style: ts0c_12_500,
          ),
          names_input('Enter lastname', _lastNameController),
          Text(
            'Midname',
            style: ts0c_12_500,
          ),
          names_input('Enter midname', _midNameController),
          // Text(
          //   'IIN*',
          //   style: ts0c_12_500,
          // ),
          // iin_input(),
          Text(
            'Phone number',
            style: ts0c_12_500,
          ),
          phone_input(),
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
          names_input('Enter address', _addressController),
          Text(
            'Street, house',
            style: tsgr_12_400,
          ),
        ],
      ),
    );
  }

  GestureDetector float_button() {
    return GestureDetector(
      onTap: () {
        _canGo
            ? context.read<GetUserprofileBloc>().add(
                  SetUserprofileEvent(
                    RegistrationUserModel(
                      iin: '_iinController.text',
                      password: ' passwordController.text',
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      middleName: _midNameController.text,
                      phoneNumber: _phoneController.text
                          .replaceAll(' ', '')
                          .replaceAll('-', ''),
                      // cityName: citiesList[_cityId],
                      cityName: _choosedCity!,
                      address: _addressController.text,
                    ),
                  ),
                )
            : null;
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        height: 44,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _canGo ? blue : greyEF,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Edit',
          style: tsgr_12_400,
        ),
      ),
    );
  }

  Widget choose_city() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFocused = false;
        });
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
        controller: _phoneController,
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

  // Container iin_input() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: white,
  //       borderRadius: BorderRadius.all(Radius.circular(16)),
  //     ),
  //     margin: EdgeInsets.symmetric(vertical: 12),
  //     child: TextFormField(
  //       textInputAction: TextInputAction.next,
  //       controller: _iinController,
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //         hintText: 'Enter IIN',
  //         hintStyle: tsgr_14_400,
  //         // contentPadding: EdgeInsets.all(0),
  //         contentPadding:
  //             EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
  //         border: OutlineInputBorder(
  //           borderSide: const BorderSide(width: 1, color: greyA8),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: const BorderSide(width: 1, color: blue),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         counter: SizedBox(),
  //         alignLabelWithHint: true,
  //       ),
  //       maxLength: 12,
  //       onChanged: (value) {
  //         checkGo();
  //         // setState(() {
  //         //   isFormsActive = true;
  //         // });
  //       },
  //       onTap: () {
  //         setState(() {
  //           _isFocused = true;
  //         });
  //       },
  //       // onEditingComplete: () => setState(() {
  //       //   isFormsActive = false;
  //       // }),
  //     ),
  //   );
  // }

  void checkGo() {
    if (
        //
        // _iinController.text.isNotEmpty &&
        //   _iinController.text.length == 12 &&
        _addressController.text.isNotEmpty &&
            _phoneController.text.isNotEmpty &&
            _firstNameController.text.isNotEmpty &&
            _lastNameController.text.isNotEmpty &&
            _addressController.text.isNotEmpty &&
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
