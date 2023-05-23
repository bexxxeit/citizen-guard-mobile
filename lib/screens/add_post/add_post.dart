// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:diploma_citizen/data/constants/sized_boxes.dart';
import 'package:diploma_citizen/data/models/add_post_type_model.dart';
import 'package:diploma_citizen/screens/add_post/alert_page.dart';
import 'package:diploma_citizen/screens/components/list_data/alert_choose_city.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../data/constants/colors.dart';
import '../../data/constants/textStyles.dart';
// import '../../data/constants/texts.dart';
import '../components/list_data/alert_choose_category.dart';
// import '../home/home_page.dart';

bool _isFocused = false;
int _pageIndex = 0;
// int _categoryId = -1;
// int _cityId = -1;
// int _distirctId = -1;
String? _selectedCity = null;
String? _selectedDistirct = null;
String? _selectedCategory = null;
String? _selectedCategoryCode = null;
bool _canGo = false;
// GlobalKey<ScaffoldState> _key = GlobalKey();
DateTime _selectedDt = DateTime(1999);
TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);
TextEditingController _descripttionCont = TextEditingController();
TextEditingController _addInfoCont = TextEditingController();
XFile? _selectedImage;
final ImagePicker imagePicker = ImagePicker();

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isFocused = false;
    _pageIndex = 0;
    _selectedCity = null;
    _selectedDistirct = null;
    _selectedCategory = null;
    _selectedCategoryCode = null;
    _canGo = false;
    _selectedDt = DateTime(1999);
    _selectedTime = TimeOfDay(hour: 0, minute: 0);
    _descripttionCont = TextEditingController();
    _addInfoCont = TextEditingController();
    _selectedImage = null;
  }

  void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isFocused = false;
    });
  }

  void selectImages() async {
    final XFile? selectedImages = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (selectedImages != null) {
      setState(() {
        _selectedImage = selectedImages;
      });
      checkGo();
    }
    // selectedImages.isNotEmpty
    //     ? setState(() {
    //         // hasPhoto = true;
    //         // widget.stCanTap();
    //       })
    //     : setState(() {
    //         // hasPhoto = false;
    //       });
  }

  var boxDecorationImage = BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: white,
    boxShadow: [
      BoxShadow(
        color: blackB2.withOpacity(0.15),
        spreadRadius: 0,
        blurRadius: 4,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: blackB2.withOpacity(0.15),
        spreadRadius: 0,
        blurRadius: 4,
        offset: const Offset(0, 4),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        unFocus();
      },
      child: Scaffold(
        appBar: appBar(),
        // key: _key,
        backgroundColor: white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      levels_body(),
                      be_Care(maxWidth),
                      _pageIndex == 0
                          ? place_widgets()
                          : _pageIndex == 1
                              ? dateWidgets()
                              : informationWidgets(),
                    ],
                  ),
                ),
              ),
              bottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Column informationWidgets() {
    return Column(
      children: [
        descript(),
        sb_h16(),
        addInfo(),
        sb_h16(),
        imagePick(),
      ],
    );
  }

  Column imagePick() {
    double maxWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Image*',
          style: ts0c_12_500,
        ),
        sb_h4(),
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: blackB2.withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.add_photo_alternate_rounded,
                color: greyD3,
                size: 18,
              ),
            ),
            sb_w4(),
            GestureDetector(
              onTap: () {
                selectImages();
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: blackB2.withOpacity(0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.add,
                  color: blue,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        _selectedImage != null
            ? Container(
                width: (maxWidth - 32),
                height: (maxWidth - 32),
                decoration: boxDecorationImage,
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: greyA8,
                    image: DecorationImage(
                      image: FileImage(File(_selectedImage!.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child: SvgPicture.asset(
                  //   'assets/icons/accident_image.svg',
                  //   fit: BoxFit.cover,
                  // ),
                  // child: Image(
                  //   image: AssetImage(
                  //     'assets/images/accident_image.png',
                  //   ),
                  //   fit: BoxFit.cover,
                  // ),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Column dateWidgets() {
    return Column(
      children: [
        dateChoose(),
        sb_h16(),
        timeChoose(),
        sb_h16(),
        categoryChoose(),
      ],
    );
  }

  Column place_widgets() {
    return Column(
      children: [
        cityChoose(),
        sb_h16(),
        distirctChoose(),
      ],
    );
  }

  void checkGo() {
    if (_pageIndex == 0
        ? _selectedCity != null && _selectedDistirct != null
        : _pageIndex == 1
            ? _selectedDt.year != 1999 && _selectedCategory != null
            : _descripttionCont.text.isNotEmpty &&
                // _addInfoCont.text.isNotEmpty &&
                _selectedImage != null) {
      setState(() {
        _canGo = true;
      });
    } else {
      setState(() {
        _canGo = false;
      });
    }
  }

  Column addInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: ts0c_12_500,
        ),
        sb_h4(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: greyA8, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _addInfoCont,
            style: ts0c_12_400,
            maxLength: 100,
            cursorColor: greyA8,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintStyle: tsgr_12_400,
              hintText: 'Enter additional text if necessary',
            ),
            onChanged: (value) {
              checkGo();
            },
          ),
        ),
        sb_h8(),
      ],
    );
  }

  Column descript() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description of the incident*',
          style: ts0c_12_500,
        ),
        sb_h4(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: greyA8, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: _descripttionCont,
            style: ts0c_12_400,
            maxLength: 100,
            cursorColor: greyA8,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintStyle: tsgr_12_400,
              hintText: 'Enter as much information as possible',
            ),
            onChanged: (value) {
              checkGo();
            },
          ),
        ),
        sb_h8(),
      ],
    );
  }

  Column timeChoose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Incident time*',
          style: ts0c_12_500,
        ),
        sb_h4(),
        GestureDetector(
          onTap: () async {
            final TimeOfDay? _tod = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            print(_tod);
            if (_tod != null) {
              print('true');
              setState(() {
                _selectedTime = _tod;
              });
            }
            print(_selectedDt);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: greyA8, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 104,
                  child: Text(
                    // '${_selectedTime.hour}:${_selectedTime.minute}',
                    _selectedTime.format(context),
                    style: ts0c_12_400,
                  ),
                ),
                Icon(
                  Icons.date_range,
                  color: black0C,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        sb_h8(),
      ],
    );
  }

  Column dateChoose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Incident date*',
          style: ts0c_12_500,
        ),
        sb_h4(),
        GestureDetector(
          onTap: () async {
            final DateTime? _dt = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            print(_dt);
            if (_dt != null) {
              print('true');
              setState(() {
                _selectedDt = _dt;
              });
            }
            print(_selectedDt);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: greyA8, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 104,
                  child: Text(
                    _selectedDt.year != 1999
                        ? DateFormat('dd/MM/yyyy').format(_selectedDt)
                        : 'Choose date',
                    style: _selectedDt.year != 1999 ? ts0c_12_400 : tsgr_12_400,
                  ),
                ),
                Icon(
                  Icons.date_range,
                  color: black0C,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        sb_h8(),
      ],
    );
  }

  Column categoryChoose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Post category*',
          style: ts0c_12_500,
        ),
        sb_h4(),
        GestureDetector(
          onTap: () {
            // _key.currentState!.showBottomSheet(
            //   // showBottomSheet(
            //   //   context: context,
            //   //   builder:
            //   // context: context,
            //   (context) {
            //     // return bottomSheetBody((int index) {
            //     //   setState(() {
            //     //     _cityId = index;
            //     //   });
            //     // });
            //     return DraggableScrollableSheet(
            //       initialChildSize: 0.6,
            //       snap: true,
            //       builder: (BuildContext context,
            //           ScrollController scrollController) {
            //         // return ListCitiesBody(
            //         //   stcityId: setCityId,
            //         //   scrollController: scrollController,
            //         // );
            //         return ListCategoriesBody(
            //           stcityId: setCategoId,
            //           scrollController: scrollController,
            //           // listData: categoriesList,
            //           title: 'Choose category',
            //           close: () {
            //             // Navigator.pop(context);
            //           },
            //         );
            //       },
            //     );
            //   },
            //   backgroundColor: Colors.transparent,
            // );
            showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AlertSetCategory(
                stcityId: setCategoId,
                // listData: categoriesList,
                title: 'Choose category',
                close: () {
                  // Navigator.pop(context);
                },
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: greyA8, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 104,
                  child: Text(
                    _selectedCategory != null
                        ? _selectedCategory!
                        : 'Choose category',
                    style:
                        _selectedCategory != null ? ts0c_12_400 : tsgr_12_400,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: black0C,
                ),
              ],
            ),
          ),
        ),
        sb_h8(),
      ],
    );
  }

  Column cityChoose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'City*',
          style: ts0c_12_500,
        ),
        sb_h4(),
        GestureDetector(
          onTap: () {
            // _key.currentState!.showBottomSheet(
            //   // showBottomSheet(
            //   //   context: context,
            //   //   builder:
            //   // context: context,
            //   (context) {
            //     // return bottomSheetBody((int index) {
            //     //   setState(() {
            //     //     _cityId = index;
            //     //   });
            //     // });
            //     return DraggableScrollableSheet(
            //       initialChildSize: 0.6,
            //       snap: true,
            //       builder: (BuildContext context,
            //           ScrollController scrollController) {
            //         // return ListCitiesBody(
            //         //   stcityId: setCityId,
            //         //   scrollController: scrollController,
            //         // );
            //         return ListDataBody(
            //           stcityId: setCityId,
            //           scrollController: scrollController,
            //           // listData: citiesList,
            //           title: 'Enter city',
            //           close: () {
            //             // Navigator.pop(context);
            //           },
            //           cityName: '', isCity: true,
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
                stcityId: setCityId,
                // listData: citiesList,
                title: 'Enter city',
                close: () {
                  // Navigator.pop(context);
                },
                cityName: '', isCity: true,
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: greyA8, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 104,
                  child: Text(
                    _selectedCity != null ? _selectedCity! : 'Enter city',
                    style: _selectedCity != null ? ts0c_12_400 : tsgr_12_400,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: black0C,
                ),
              ],
            ),
          ),
        ),
        sb_h8(),
      ],
    );
  }

  Column distirctChoose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Distirct*',
          style: ts0c_12_500,
        ),
        sb_h4(),
        GestureDetector(
          onTap: () {
            _selectedCity != null
                // ? _key.currentState!.showBottomSheet(
                //     // showBottomSheet(
                //     //   context: context,
                //     //   builder:
                //     // context: context,
                //     (context) {
                //       // return bottomSheetBody((int index) {
                //       //   setState(() {
                //       //     _cityId = index;
                //       //   });
                //       // });
                //       return DraggableScrollableSheet(
                //         initialChildSize: 0.6,
                //         snap: true,
                //         builder: (BuildContext context,
                //             ScrollController scrollController) {
                //           // return ListCitiesBody(
                //           //   stcityId: setCityId,
                //           //   scrollController: scrollController,
                //           // );
                //           return ListDataBody(
                //             stcityId: setDistrId,
                //             scrollController: scrollController,
                //             // listData: citiesList,
                //             title: 'Enter distirct',
                //             close: () {
                //               // Navigator.pop(context);
                //             },
                //             isCity: false,
                //             cityName: _selectedCity!,
                //           );
                //         },
                //       );
                //     },
                //     backgroundColor: Colors.transparent,
                //   )
                ? showGeneralDialog(
                    context: context,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AlertSetRegionCity(
                      stcityId: setDistrId,
                      // scrollController: scrollController,
                      // listData: citiesList,
                      title: 'Enter distirct',
                      close: () {
                        // Navigator.pop(context);
                      },
                      isCity: false,
                      cityName: _selectedCity!,
                    ),
                  )
                : null;
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: greyA8, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 104,
                  child: Text(
                    _selectedDistirct != null
                        ? _selectedDistirct!
                        : 'Enter distirct',
                    style: _selectedCity != null ? ts0c_12_400 : tsgr_12_400,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: black0C,
                ),
              ],
            ),
          ),
        ),
        sb_h8(),
      ],
    );
  }

  setCategoId(String category, String categoryCode) {
    setState(() {
      _selectedCategory = category;
      _selectedCategoryCode = categoryCode;
    });
    checkGo();
  }

  setDistrId(String district) {
    setState(() {
      _selectedDistirct = district;
    });
    checkGo();
  }

  setCityId(String city) {
    setState(() {
      _selectedCity = city;
    });
    checkGo();
  }

  Container be_Care(double maxWidth) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: blueD3,
      ),
      child: SizedBox(
        width: maxWidth - 48,
        child: Text(
          'Be Careful When Filling Out Incident Details',
          style: tsbl_12_400,
        ),
      ),
    );
  }

  Row bottomButtons() {
    return Row(
      children: [
        _pageIndex != 0
            ? Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageIndex != 0 ? _pageIndex-- : null;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: blueD3,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chevron_left,
                          size: 18,
                          color: blue,
                        ),
                        Text(
                          'Back',
                          style: tsbl_12_400,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(),
        _pageIndex != 0 ? sb_w16() : SizedBox(),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (_canGo) {
                if (_pageIndex != 2) {
                  setState(() {
                    _pageIndex++;
                    _canGo = false;
                  });
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AlertPage(
                          apm: AddPostModel(
                            city: _selectedCity!,
                            distirct: _selectedDistirct!,
                            time: DateFormat('dd-MM-yyyy').format(_selectedDt) +
                                ' ' +
                                _selectedTime.format(context),
                            // _selectedTime.toString(),
                            // '13:10',
                            category: _selectedCategoryCode!,
                            description: _descripttionCont.text,
                            addInfo: _addInfoCont.text,
                            imagePath: File(
                              _selectedImage!.path,
                            ),
                          ),
                        );
                      },
                    ),
                  ).then((value) => setState(() {
                        _pageIndex = 0;
                        _selectedCity = null;
                        _selectedCategory = null;
                        _addInfoCont.clear();
                        _descripttionCont.clear();
                        _canGo = false;
                        _selectedCategoryCode = null;
                        _selectedDt = DateTime(1999);
                        _selectedTime = TimeOfDay(hour: 0, minute: 0);
                        _selectedImage = null;
                      }));
                }
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _canGo ? blue : greyEF,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _pageIndex == 2 ? 'Send' : 'Next',
                    style: _canGo ? tswh_12_400 : tsgr_12_400,
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: _canGo ? white : greyBE,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Material levels_body() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.circular(16),
      shadowColor: blackB2.withOpacity(0.3),
      // width: maxWidth - 32,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(16),
      //     topRight: Radius.circular(16),
      //     bottomLeft: Radius.circular(16),
      //     bottomRight: Radius.circular(16),
      //   ),
      //   color: Colors.white.withOpacity(0),
      //   // boxShadow: [
      //   //   BoxShadow(
      //   //     color: blackB2.withOpacity(0.15),
      //   //     spreadRadius: 0,
      //   //     blurRadius: 3,
      //   //     offset: const Offset(0, 2),
      //   //   ),
      //   // ],
      // ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _pageIndex == 0 ? blue : white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: blackB2.withOpacity(0.15),
                //     spreadRadius: 0,
                //     blurRadius: 3,
                //     offset: const Offset(0, 2),
                //   ),
                // ],
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(color: blackB2, width: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_sharp,
                      color: _pageIndex == 0 ? white : blue,
                      size: 18,
                    ),
                    sb_w4(),
                    Text(
                      'Place',
                      style: _pageIndex == 0 ? tswh_12_400 : tsbl_12_400,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _pageIndex == 1 ? blue : white,
                border: Border.symmetric(
                  vertical: BorderSide(color: blackB2, width: 0.2),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: blackB2.withOpacity(0.15),
                //     spreadRadius: 0,
                //     blurRadius: 3,
                //     offset: const Offset(0, 2),
                //   ),
                // ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.date_range,
                    color: _pageIndex == 1 ? white : blue,
                    size: 18,
                  ),
                  sb_w4(),
                  Text(
                    'Date',
                    style: _pageIndex == 1 ? tswh_12_400 : tsbl_12_400,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _pageIndex == 2 ? blue : white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: blackB2.withOpacity(0.15),
                //     spreadRadius: 0,
                //     blurRadius: 3,
                //     offset: const Offset(0, 2),
                //   ),
                // ],
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: blackB2,
                      width: 0.2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: _pageIndex == 2 ? white : blue,
                      size: 18,
                    ),
                    sb_w4(),
                    Text(
                      'Information',
                      style: _pageIndex == 2 ? tswh_12_400 : tsbl_12_400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
        child: const Icon(
          Icons.arrow_back,
          color: black0C,
        ),
      ),
      title: Text(
        'Add post',
        style: ts0c_16_500,
      ),
    );
  }
}
