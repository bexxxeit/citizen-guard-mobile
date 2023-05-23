// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:diploma_citizen/data/constants/colors.dart';
import 'package:diploma_citizen/data/constants/sized_boxes.dart';
import 'package:diploma_citizen/data/constants/textStyles.dart';

import '../components/list_data/alert_choose_category.dart';
import '../components/list_data/alert_choose_city.dart';
// import '../auth/other_pages/registration_page.dart';
import '../../data/models/post_tile_model.dart';
import '../single_post/single_post_page.dart';
import 'get_search_posts_bloc/get_search_posts_bloc.dart';
// import '../home/home_page.dart';

TextEditingController _numberController = TextEditingController();
bool _isFocused = false;
// GlobalKey<ScaffoldState> _key = GlobalKey();
String? _selectedCategory;
String? _selectedCategoryCode;
int _cityId = -1;
bool _canGo = false;
bool _isSearched = false;
late PersistentBottomSheetController _controllerBottom;
String _role = '';
var _userTypeBox = Hive.box('userType');
String? _selectedCityD;

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    this.cityname,
  }) : super(key: key);
  final String? cityname;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isFocused = false;
    });
    checkGo();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _role = _userTypeBox.get('key');
    print(_role);
    print(widget.cityname);
    _selectedCityD = null;
    _selectedCategory = null;
    _selectedCategoryCode = null;
    _numberController.clear();
    _canGo = false;
    context.read<GetSearchPostsBloc>().add(GetUserPostsEmit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSearchPostsBloc, GetSearchPostsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            unFocus();
          },
          child: Scaffold(
            appBar: appBar(context),
            // key: _key,
            backgroundColor: white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    category(),
                    number_input_body(),
                    _role != 'ROLE_USER' ? city_distirct() : SizedBox(),
                    button(context),
                    // _isSearched
                    //     ? AnimatedContainer(
                    state is GetUserPostsLoading
                        ? Container(
                            width: double.infinity,
                            height: 300,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [CircularProgressIndicator()],
                            ),
                          )
                        : state is GetUserPostsSuccess
                            ? AnimatedContainer(
                                duration: Duration(milliseconds: 300 * 3),
                                child: Column(
                                  children: List.generate(
                                    state.posts.length,
                                    // (index) => post_tile(listPostTiles[index],
                                    (index) => post_tile(state.posts[index],
                                        MediaQuery.of(context).size.width),
                                  ),
                                ),
                              )
                            : state is GetUserPostsFailure
                                ? Container(
                                    width: double.infinity,
                                    height: 300,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'ERROR',
                                      style: tsred_12_500,
                                    ),
                                  )
                                : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  GestureDetector button(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //dosth
        _canGo
            // ? setState(
            //     () {
            //       _isSearched = true;
            //     },
            //   )
            ? context.read<GetSearchPostsBloc>().add(
                  GetUserPosts(
                    initDate: '',
                    finDate: '',
                    category: _selectedCategoryCode ?? '',
                    status: '',
                    city: _role == 'ROLE_USER'
                        ? ''
                        : _role == 'ROLE_PROSECUTOR'
                            ? _selectedCityD ?? ''
                            : widget.cityname ?? '',
                    district: _role == 'ROLE_USER'
                        ? ''
                        : _role != 'ROLE_PROSECUTOR'
                            ? _selectedCityD ?? ''
                            : '',
                    // ? _cityId != -1
                    //     ? _cityId.toString()
                    //     : ''
                    // : '',
                    number: _numberController.text.isEmpty
                        ? ''
                        : _numberController.text,
                  ),
                )
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Search  ',
              style: tsgr_12_400,
            ),
            Icon(
              Icons.search,
              color: greyBE,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector post_tile(PostTileModel ptm, double maxW) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SinglePostPage(
            id: ptm.id,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            sb_h16(),
            top_post_tile(ptm),
            Container(
              width: maxW - 32,
              color: whitefc,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Text(
                ptm.title,
                style: ts0c_12_400,
              ),
            ),
            Container(
              height: 1,
              width: maxW - 64,
              color: blueD3,
            ),
            Container(
              width: maxW - 32,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: whitefc,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      spreadRadius: 4,
                      blurRadius: 8,
                      color: Color(0xffA09898).withOpacity(0.15),
                    ),
                  ]),
              alignment: Alignment.centerRight,
              child: Text(
                // DateFormat('yyyy.MM.dd hh:mm').format(ptm.postDate),
                ptm.postDate,
                style: ts0c_12_400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container top_post_tile(PostTileModel ptm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: _role != 'ROLE_USER'
            ? blue
            : ptm.status == 1
                ? orangeED
                : ptm.status == 2
                    ? greenAC
                    : redF6,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Text(
        '№ ${ptm.number}',
        style: tswh_12_600,
      ),
    );
  }

  void checkGo() {
    if (_numberController.text.isNotEmpty ||
        (_role != 'ROLE_USER' ? _selectedCityD != null : true) ||
        // (_role != 'ROLE_USER' ? _cityId != -1 : true) ||
        _selectedCategory != null) {
      setState(() {
        _canGo = true;
      });
    } else {
      setState(() {
        _canGo = false;
      });
    }
  }

  Column number_input_body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search by number',
          style: ts0c_12_500,
        ),
        sb_h4(),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            controller: _numberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter number',
              hintStyle: tsgr_14_400,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffA8A9BC)),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: blue),
                borderRadius: BorderRadius.circular(15),
              ),
              suffix: Icon(
                Icons.search,
                color: black0C,
              ),
              isDense: true,
              counter: SizedBox(),
              alignLabelWithHint: true,
            ),
            maxLength: 12,
            onChanged: (value) {
              checkGo();
            },

            // onEditingComplete: () => setState(() {
            //   isFormsActive = false;
            // }),
          ),
        ),
        sb_h8(),
      ],
    );
  }

  Column city_distirct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search by ${_role == 'ROLE_PROSECUTOR' ? 'city' : 'district'}',
          style: ts0c_12_500,
        ),
        sb_h4(),
        GestureDetector(
          onTap: () {
            // _controllerBottom = _key.currentState!.showBottomSheet(
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
            //           title:
            //               'Choose ${_role == 'ROLE_PROSECUTOR' ? 'city' : 'district'}',
            //           close: () {
            //             // Navigator.pop(context);
            //           },
            //           cityName:
            //               _role == 'ROLE_PROSECUTOR' ? '' : widget.cityname!,
            //           isCity: _role == 'ROLE_PROSECUTOR',
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
                title:
                    'Choose ${_role == 'ROLE_PROSECUTOR' ? 'city' : 'district'}',
                close: () {
                  // Navigator.pop(context);
                },
                cityName: _role == 'ROLE_PROSECUTOR' ? '' : widget.cityname!,
                isCity: _role == 'ROLE_PROSECUTOR',
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
                    // _cityId != -1 ? citiesList[_cityId] : 'Choose',
                    _selectedCityD != null ? _selectedCityD! : 'Choose',
                    // _cityId != -1 ? _selectedCityD! : 'Choose',
                    style: _selectedCityD != null ? ts0c_12_400 : tsgr_12_400,
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

  // setCityId(String indexname, int index) {
  setCityId(String indexname) {
    setState(() {
      _selectedCityD = indexname;
      // _cityId = index;
    });
    checkGo();
  }

  Column category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search by category',
          style: ts0c_12_500,
        ),
        sb_h4(),
        GestureDetector(
          onTap: () {
            // _key.currentState!.showBottomSheet(
            //   // context: context,
            //   (context) {
            //     return DraggableScrollableSheet(
            //       initialChildSize: 0.4,
            //       snap: true,
            //       builder: (BuildContext context,
            //           ScrollController scrollController) {
            //         return ListCategoriesBody(
            //           stcityId: setCatId,
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
                stcityId: setCatId,
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
                    _selectedCategory != null ? _selectedCategory! : 'Choose',
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

  setCatId(String category, String code) {
    setState(() {
      // _categoryId = index;
      _selectedCategory = category;
      _selectedCategoryCode = code;
    });
    checkGo();
  }

  AppBar appBar(BuildContext context) {
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
        'Search post',
        style: ts0c_16_500,
      ),
      actions: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = null;
              _numberController.clear();
              _canGo = false;
              // context.read<GetSearchPostsBloc>().add(
              //       GetUserPosts(
              //     initDate: '',
              //     finDate: '',
              //     category: '',
              //     status: '',
              //     city:  '',
              //     district:  '',
              //     number:  '',
              //   ),
              //     );
            });
          },
          child: Icon(
            Icons.replay,
            color: blue,
          ),
        ),
        sb_w16(),
      ],
    );
  }
}
