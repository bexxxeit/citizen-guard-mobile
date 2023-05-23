// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diploma_citizen/screens/components/list_data/alert_choose_status.dart';
import 'package:diploma_citizen/screens/single_post/single_post_page.dart';
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

import '../components/list_data/alert_choose_category.dart';
import 'bloc/get_user_posts_bloc/get_user_posts_bloc.dart';

bool _isChoosedDate = false;
DateTime? _initDate;
DateTime? _lastDate;
String? _selectedCategory;
int _statusId = -1;
// GlobalKey<ScaffoldState> widget.keyG = GlobalKey();
// GlobalKey<ScaffoldState> _key = GlobalKey();

bool _isUser = true;

class ListPosts extends StatefulWidget {
  const ListPosts({
    Key? key,
    // required this.keyG,
  }) : super(key: key);
  // final GlobalKey<ScaffoldState> keyG;

  @override
  State<ListPosts> createState() => _ListPostsState();
}

var userTypeBox = Hive.box('userType');
bool _isSimpleUser = true;

class _ListPostsState extends State<ListPosts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _statusId = 0;
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
            status: _statusId != 0 ? statusList[_statusId] : '',
          ),
        );
    _isSimpleUser = userTypeBox.get('key') == 'ROLE_USER';
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
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
                          // filter_row(),
                          Column(
                            children: List.generate(
                              // listPostTiles.length,
                              state.posts.length,
                              // (index) => post_tile(listPostTiles[index], maxWidth),
                              (index) =>
                                  post_tile(state.posts[index], maxWidth),
                            ),
                          ),
                          SizedBox(height: 50)
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
                            width: maxWidth - 50,
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
        ],
      ),
    );
  }

  GestureDetector status_filter() {
    return GestureDetector(
      onTap: () {
        // widget.keyG.currentState!.showBottomSheet(
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
        // widget.keyG.currentState!.showBottomSheet(
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
            stcityId: (String cate) {
              // setCatId(cate);
              setState(() {
                // _categoryId = index;
                _selectedCategory = cate;
              });
              Navigator.pop(context);
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
                      category: cate,
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
}
