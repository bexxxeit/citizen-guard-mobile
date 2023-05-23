// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import 'package:diploma_citizen/screens/add_post/add_post.dart';
import 'package:diploma_citizen/screens/auth/login_page.dart';
import 'package:diploma_citizen/screens/components/list_data/alert_choose_category.dart';
import 'package:diploma_citizen/screens/components/list_data/alert_choose_status.dart';
import 'package:diploma_citizen/screens/home/profile_info.dart';
import 'package:diploma_citizen/screens/search/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:diploma_citizen/data/constants/assets.dart';
import 'package:diploma_citizen/data/constants/colors.dart';
import 'package:diploma_citizen/data/constants/sized_boxes.dart';
import 'package:diploma_citizen/data/constants/textStyles.dart';
import 'package:diploma_citizen/data/constants/texts.dart';
import 'package:diploma_citizen/data/models/post_tile_model.dart';

import '../single_post/single_post_page.dart';
import 'bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'bloc/user_me_bloc/user_me_bloc.dart';
import 'list_posts.dart';

var tokenBox = Hive.box('tokens');

bool _isChoosedDate = false;
DateTime? _initDate;
DateTime? _lastDate;
String? _selectedCategory;
String? _selectedCode;
int _statusId = -1;
// GlobalKey<ScaffoldState> _key = GlobalKey();

bool _isSimpleUser = true;
bool _isUser = true;
var _userTypeBox = Hive.box('userType');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isChoosedDate = false;
    _statusId = 0;
    _isUser = _userTypeBox.get('key') == 'ROLE_USER';
    context.read<UserMeBloc>().add(UserMeEvent());
    // context.read<GetUserPostsBloc>().add(
    //       GetUserPosts(
    //         city: '',
    //         district: '',
    //         initDate: '',
    //         finDate: '',
    //         category: '',
    //         status: '',
    //       ),
    //     );
    _isSimpleUser = _userTypeBox.get('key') == 'ROLE_USER';
  }

  @override
  Widget build(BuildContext context) {
    double maxW = MediaQuery.of(context).size.width;
    return BlocBuilder<UserMeBloc, UserMeState>(
      builder: (context, state) {
        if (state is UserMeFailure) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
            );
          });
        } else if (state is UserMeSuccess) {
          _isUser = state.userType.role == 'ROLE_USER';
        }
        return Scaffold(
          appBar: appBar(),
          // key: _key,
          backgroundColor: white,
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: float_buttons(),
          body: state is UserMeLoading
              ? SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                )
              : state is UserMeSuccess?
                  ? RefreshIndicator(
                      onRefresh: () async {
                        context.read<UserMeBloc>().add(UserMeEvent());
                        context.read<GetUserPostsBloc>().add(
                              GetUserPosts(
                                city: '',
                                district: '',
                                initDate: '',
                                finDate: '',
                                category: '',
                                status: '',
                              ),
                            );
                      },
                      child: Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: with_posts_body(maxW, state),
                          ),
                          Positioned(
                            bottom: 0,
                            child: SizedBox(
                              width: maxW,
                              child: float_buttons(state is UserMeSuccess
                                  ? state.userType.city
                                  : ''),
                            ),
                          ),
                        ],
                      ),
                    )
                  : state is UserMeFailure
                      ? SizedBox(
                          height: 100,
                          child: Text(
                            'ERROR',
                            style: tsred_12_500,
                          ),
                        )
                      : null,
        );
      },
    );
  }

  SingleChildScrollView with_posts_body(double maxW, UserMeState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                account_name(state is UserMeSuccess ? state.userType.name : ''),
                sb_h8(),
                filter_row(),
                ListPosts(
                    // keyG: _key,
                    ),
                // listPosts(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listPosts() {
    return BlocBuilder<GetUserPostsBloc, GetUserPostsState>(
      builder: (context, state) {
        return state is GetUserPostsLoading
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
                ? state.posts.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          filter_row(),
                          Column(
                            children: List.generate(
                              // listPostTiles.length,
                              state.posts.length,
                              // (index) => post_tile(listPostTiles[index], maxWidth),
                              (index) => post_tile(state.posts[index],
                                  MediaQuery.of(context).size.width),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 200),
                          Icon(
                            Icons.crop_free,
                            color: greyA8,
                          ),
                          sb_h24(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            child: Text(
                              'You haven\'t added yet\npost',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
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
                    : SizedBox();
      },
    );
  }

  SingleChildScrollView filter_row() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(filter_icon),
          sb_w8(),
          date_filter(),
          sb_w8(),
          category_filter(),
          sb_w8(),
          status_filter(),
          sb_w8(),
          GestureDetector(
            onTap: () {
              setState(() {
                _initDate = null;
                _lastDate = null;
                _statusId = 0;
                _isChoosedDate = false;
                _selectedCategory = null;
                context.read<GetUserPostsBloc>().add(
                      GetUserPosts(
                        city: '',
                        district: '',
                        initDate: '',
                        finDate: '',
                        category: '',
                        status: '',
                      ),
                    );
              });
            },
            child: Icon(
              Icons.replay,
              color: blue,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector status_filter() {
    return GestureDetector(
      onTap: () {
        // _key.currentState!.showBottomSheet(
        //   // _key.currentState!.showBottomSheet(
        //   // context: context,
        //   (context) {
        //     return DraggableScrollableSheet(
        //       initialChildSize: 0.4,
        //       // initialChildSize: 0.3,
        //       snap: false,
        //       builder:
        //           (BuildContext context, ScrollController scrollController) {
        //         return ListStatusBody(
        //           stcityId: (int index) {
        //             setStatusId(index);
        //             context.read<GetUserPostsBloc>().add(
        //                   GetUserPosts(
        //                     city: '',
        //                     district: '',
        //                     initDate: _initDate != null
        //                         ? DateFormat('dd-MM-yyyy').format(_initDate!)
        //                         : '',
        //                     finDate: _lastDate != null
        //                         ? DateFormat('dd-MM-yyyy').format(_lastDate!)
        //                         : '',
        //                     category: _selectedCategory ?? '',
        //                     status: index != 0 ? statusList[index] : '',
        //                   ),
        //                 );
        //             Navigator.pop(context);
        //           },
        //           scrollController: scrollController,
        //           listData: statusList,
        //           title: 'Choose status',
        //           close: () {
        //             Navigator.pop(context);
        //           },
        //         );
        //       },
        //     );
        //     ;
        //   },
        //   backgroundColor: Colors.transparent,
        // );
        showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) =>
              AlertSetStatus(
            stcityId: (int index) {
              setStatusId(index);
              context.read<GetUserPostsBloc>().add(
                    GetUserPosts(
                      city: '',
                      district: '',
                      initDate: _initDate != null
                          ? DateFormat('dd-MM-yyyy').format(_initDate!)
                          : '',
                      finDate: _lastDate != null
                          ? DateFormat('dd-MM-yyyy').format(_lastDate!)
                          : '',
                      category: _selectedCategory ?? '',
                      status: index != 0 ? statusList[index] : '',
                    ),
                  );
              Navigator.pop(context);
            },
            listData: statusList,
            title: 'Choose status',
            close: () {
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: blue, width: 1),
          color: _statusId != 0 ? blue : white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          _statusId != 0 ? statusList[_statusId] : 'Status',
          style: _statusId != 0 ? tswh_12_500_20 : tsbl_12_500_20,
        ),
      ),
    );
  }

  GestureDetector category_filter() {
    return GestureDetector(
      onTap: () {
        // _key.currentState!.showBottomSheet(
        //   // context: context,
        //   (context) {
        //     return DraggableScrollableSheet(
        //       initialChildSize: 0.4,
        //       snap: true,
        //       builder:
        //           (BuildContext context, ScrollController scrollController) {
        //         return ListCategoriesBody(
        //           stcityId: (String cate) {
        //             // setCatId(cate);
        //             setState(() {
        //               // _categoryId = index;
        //               _selectedCategory = cate;
        //             });
        //             Navigator.pop(context);
        //             context.read<GetUserPostsBloc>().add(
        //                   GetUserPosts(
        //                     city: '',
        //                     district: '',
        //                     initDate: _initDate != null
        //                         ? DateFormat('dd-MM-yyyy').format(_initDate!)
        //                         : '',
        //                     finDate: _lastDate != null
        //                         ? DateFormat('dd-MM-yyyy').format(_lastDate!)
        //                         : '',
        //                     category: cate,
        //                     status: _statusId != 0 ? statusList[_statusId] : '',
        //                   ),
        //                 );
        //           },
        //           scrollController: scrollController,
        //           // listData: categoriesList,
        //           title: 'Choose category',
        //           close: () {
        //             Navigator.pop(context);
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
            stcityId: (String cate, String code) {
              // setCatId(cate);
              setState(() {
                // _categoryId = index;
                _selectedCode = code;
                _selectedCategory = cate;
              });
              // Navigator.pop(context);
              context.read<GetUserPostsBloc>().add(
                    GetUserPosts(
                      city: '',
                      district: '',
                      initDate: _initDate != null
                          ? DateFormat('dd-MM-yyyy').format(_initDate!)
                          : '',
                      finDate: _lastDate != null
                          ? DateFormat('dd-MM-yyyy').format(_lastDate!)
                          : '',
                      category: _selectedCode ?? '',
                      status: _statusId != 0 ? statusList[_statusId] : '',
                    ),
                  );
            },
            // listData: categoriesList,
            title: 'Choose category',
            close: () {
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: blue, width: 1),
          color: _selectedCategory != null ? blue : white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Container(
          constraints: BoxConstraints(maxWidth: 123),
          child: Text(
            _selectedCategory != null ? _selectedCategory! : 'Category',
            style: _selectedCategory != null ? tswh_12_500_20 : tsbl_12_500_20,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  setStatusId(int index) {
    setState(() {
      // _statusId = index == 0
      //     ? 2
      //     : index == 1
      //         ? 0
      //         : index == 2
      //             ? 1
      //             : -1;
      _statusId = index;
    });
  }

  setCatId(String category) {
    setState(() {
      // _categoryId = index;
      _selectedCategory = category;
    });
  }

  GestureDetector date_filter() {
    return GestureDetector(
      onTap: () async {
        // showDatePicker(
        //   context: context,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime(2000),
        //   lastDate: DateTime.now(),
        // );
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            _isChoosedDate = true;
            _initDate = picked.start;
            _lastDate = picked.end;
          });
          context.read<GetUserPostsBloc>().add(
                GetUserPosts(
                  city: '',
                  district: '',
                  initDate: _initDate != null
                      ? DateFormat('dd-MM-yyyy').format(picked.start)
                      : '',
                  finDate: _lastDate != null
                      ? DateFormat('dd-MM-yyyy').format(picked.end)
                      : '',
                  category: _selectedCategory ?? '',
                  status: _statusId != 0 ? statusList[_statusId] : '',
                ),
              );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: blue, width: 1),
          color: _isChoosedDate ? blue : white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Text(
          _isChoosedDate
              ? '${DateFormat('dd.MM.yyyy').format(_initDate!)} -'
                  ' ${DateFormat('dd.MM.yyyy').format(_lastDate!)}'
              : 'Date',
          style: _isChoosedDate ? tswh_12_500_20 : tsbl_12_500_20,
        ),
      ),
    );
  }

  // GestureDetector status_filter() {
  //   return GestureDetector(
  //     onTap: () {
  //       // widget.keyG.currentState!.showBottomSheet(
  //       _key.currentState!.showBottomSheet(
  //         // context: context,
  //         (context) {
  //           return DraggableScrollableSheet(
  //             initialChildSize: 0.4,
  //             // initialChildSize: 0.3,
  //             snap: false,
  //             builder:
  //                 (BuildContext context, ScrollController scrollController) {
  //               return ListStatusBody(
  //                 stcityId: (int index) {
  //                   setStatusId(index);
  //                   Navigator.pop(context);
  //                   index != 0 ? print(statusList[index]) : null;
  //                   context.read<GetUserPostsBloc>().add(
  //                         GetUserPosts(
  //                           city: '',
  //                           district: '',
  //                           initDate: _initDate != null
  //                               ? DateFormat('dd-MM-yyyy').format(_initDate!)
  //                               : '',
  //                           finDate: _lastDate != null
  //                               ? DateFormat('dd-MM-yyyy').format(_lastDate!)
  //                               : '',
  //                           category: _selectedCategory ?? '',
  //                           status: index != 0 ? statusList[index] : '',
  //                         ),
  //                       );
  //                 },
  //                 scrollController: scrollController,
  //                 listData: statusList,
  //                 title: 'Choose status',
  //                 close: () {
  //                   Navigator.pop(context);
  //                 },
  //               );
  //             },
  //           );
  //           ;
  //         },
  //         backgroundColor: Colors.transparent,
  //       );
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(100),
  //         border: Border.all(color: blue, width: 1),
  //         color: _statusId != 0 ? blue : white,
  //       ),
  //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  //       child: Text(
  //         _statusId != 0 ? statusList[_statusId] : 'Status',
  //         style: _statusId != 0 ? tswh_12_500_20 : tsbl_12_500_20,
  //       ),
  //     ),
  //   );
  // }

  // GestureDetector category_filter() {
  //   return GestureDetector(
  //     onTap: () {
  //       _key.currentState!.showBottomSheet(
  //         // context: context,
  //         (context) {
  //           return DraggableScrollableSheet(
  //             initialChildSize: 0.4,
  //             snap: true,
  //             builder:
  //                 (BuildContext context, ScrollController scrollController) {
  //               return ListCategoriesBody(
  //                 stcityId: (String cate) {
  //                   // setCatId(cate);
  //                   setState(() {
  //                     // _categoryId = index;
  //                     _selectedCategory = cate;
  //                   });
  //                   Navigator.pop(context);
  //                   context.read<GetUserPostsBloc>().add(
  //                         GetUserPosts(
  //                           city: '',
  //                           district: '',
  //                           initDate: _initDate != null
  //                               ? DateFormat('dd-MM-yyyy').format(_initDate!)
  //                               : '',
  //                           finDate: _lastDate != null
  //                               ? DateFormat('dd-MM-yyyy').format(_lastDate!)
  //                               : '',
  //                           category: cate,
  //                           status: _statusId != 0 ? statusList[_statusId] : '',
  //                         ),
  //                       );
  //                 },
  //                 scrollController: scrollController,
  //                 // listData: categoriesList,
  //                 title: 'Choose category',
  //                 close: () {
  //                   Navigator.pop(context);
  //                 },
  //               );
  //             },
  //           );
  //         },
  //         backgroundColor: Colors.transparent,
  //       );
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(100),
  //         border: Border.all(color: blue, width: 1),
  //         color: _selectedCategory != null ? blue : white,
  //       ),
  //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  //       child: Container(
  //         constraints: BoxConstraints(maxWidth: 123),
  //         child: Text(
  //           _selectedCategory != null ? _selectedCategory! : 'Category',
  //           style: _selectedCategory != null ? tswh_12_500_20 : tsbl_12_500_20,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // setStatusId(int index) {
  //   setState(() {
  //     // _statusId = index == 0
  //     //     ? 2
  //     //     : index == 1
  //     //         ? 0
  //     //         : index == 2
  //     //             ? 1
  //     //             : -1;
  //     _statusId = index;
  //   });
  // }

  // setCatId(String category) {
  //   setState(() {
  //     // _categoryId = index;
  //     _selectedCategory = category;
  //   });
  // }

  // GestureDetector date_filter() {
  //   return GestureDetector(
  //     onTap: () async {
  //       // showDatePicker(
  //       //   context: context,
  //       //   initialDate: DateTime.now(),
  //       //   firstDate: DateTime(2000),
  //       //   lastDate: DateTime.now(),
  //       // );
  //       DateTimeRange? picked = await showDateRangePicker(
  //         context: context,
  //         firstDate: DateTime(2000),
  //         lastDate: DateTime.now(),
  //       );
  //       if (picked != null) {
  //         setState(() {
  //           _isChoosedDate = true;
  //           _initDate = picked.start;
  //           _lastDate = picked.end;
  //         });
  //         context.read<GetUserPostsBloc>().add(
  //               GetUserPosts(
  //                 city: '',
  //                 district: '',
  //                 initDate: _initDate != null
  //                     ? DateFormat('dd-MM-yyyy').format(picked.start)
  //                     : '',
  //                 finDate: _lastDate != null
  //                     ? DateFormat('dd-MM-yyyy').format(picked.end)
  //                     : '',
  //                 category: _selectedCategory ?? '',
  //                 status: _statusId != 0 ? statusList[_statusId] : '',
  //               ),
  //             );
  //       }
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(100),
  //         border: Border.all(color: blue, width: 1),
  //         color: _isChoosedDate ? blue : white,
  //       ),
  //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  //       child: Text(
  //         _isChoosedDate
  //             ? '${DateFormat('dd.MM.yyyy').format(_initDate!)} -'
  //                 ' ${DateFormat('dd.MM.yyyy').format(_lastDate!)}'
  //             : 'Date',
  //         style: _isChoosedDate ? tswh_12_500_20 : tsbl_12_500_20,
  //       ),
  //     ),
  //   );
  // }

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
        color: _isSimpleUser
            ? ptm.status == 1
                ? orangeED
                : ptm.status == 2
                    ? greenAC
                    : redF6
            : blue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '№ ${ptm.number}',
            style: tswh_12_600,
          ),
          _isSimpleUser
              ? Text(
                  ptm.status == 2
                      ? 'Approved'
                      : ptm.status == 1
                          ? 'Under consideration'
                          : 'Denied',
                  style: tswh_12_600,
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Padding float_buttons(String cityname) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isUser
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SearchPage();
                    }));
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: blueD3,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.search,
                      color: blue,
                    ),
                  ),
                )
              : SizedBox(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _isUser
                    ? AddPostPage()
                    : SearchPage(
                        cityname: cityname,
                      );
              }));
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: blueD3,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _isUser ? Icons.edit : Icons.search,
                color: blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row account_name(String name) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: blueD3,
          child: Icon(
            Icons.person,
            color: blue,
          ),
          // Text(
          //   // 'A',
          //   name.substring(0, 1),
          //   style: ts0c_20_400_24,
          // ),
        ),
        sb_w16(),
        Text(
          // 'Abylai',
          name,
          style: ts0c_16_400,
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ProfilePage();
            }));
          },
          child: Icon(
            // CupertinoIcons.ellipsis,
            Icons.edit,
            color: black0C,
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: white,
      automaticallyImplyLeading: false,
      title: Text(
        'Welcome',
        style: ts0c_12_600,
      ),
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () {
            // tokenBox
            tokenBox
                .clear()
                .then((value) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    ));
          },
          child: Icon(
            Icons.logout,
            color: black0C,
            size: 18,
          ),
        ),
        sb_w12(),
      ],
    );
  }
}

// int _index = -1;

// class ListDataBody extends StatefulWidget {
//   const ListDataBody({
//     Key? key,
//     required this.stcityId,
//     required this.scrollController,
//     required this.listData,
//     required this.title,
//     required this.close,
//   }) : super(key: key);
//   final Function stcityId;
//   final ScrollController scrollController;
//   final List<String> listData;
//   final String title;
//   final Function close;
//   @override
//   State<ListDataBody> createState() => _ListDataBodyState();
// }
// class _ListDataBodyState extends State<ListDataBody> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _index = -1;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // margin: EdgeInsets.only(top: AppBar().preferredSize.height - 20),
//       padding: EdgeInsets.all(12),
//       // height: MediaQuery.of(context).size.height -
//       //     AppBar().preferredSize.height +
//       //     20,
//       decoration: BoxDecoration(
//         color: white,
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(16),
//         ),
//       ),
//       child: SingleChildScrollView(
//         controller: widget.scrollController,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width - 96,
//                   child: Text(
//                     // 'Choose city',
//                     widget.title,
//                     style: ts0c_16_500,
//                   ),
//                 ),
//                 SizedBox(),
//                 // GestureDetector(
//                 //   onTap: () {
//                 //     // Navigator.of(context).pop();
//                 //     widget.close();
//                 //   },
//                 //   child: Container(
//                 //     decoration: BoxDecoration(
//                 //       color: greyA8,
//                 //       shape: BoxShape.circle,
//                 //     ),
//                 //     child: Icon(
//                 //       Icons.close,
//                 //       color: white,
//                 //       size: 20,
//                 //     ),
//                 //   ),
//                 // )
//               ],
//             ),
//             sb_h10(),
//             SingleChildScrollView(
//               child: Column(
//                 children: List.generate(
//                   // 20,
//                   widget.listData.length,
//                   (index) => GestureDetector(
//                     onTap: () {
//                       widget.stcityId(index);
//                       setState(() {
//                         _index = index;
//                       });
//                     },
//                     child: Container(
//                       color: _index != index ? whitef3 : blueD3,
//                       margin: EdgeInsets.symmetric(vertical: 1),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width - 96,
//                             child: Text(
//                               widget.listData[index],
//                               style: _index != index
//                                   ? tsgr_12_400_24
//                                   : tsbl_12_600_24,
//                             ),
//                           ),
//                           _index == index
//                               ? Icon(
//                                   Icons.check,
//                                   color: blue,
//                                 )
//                               : SizedBox(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
