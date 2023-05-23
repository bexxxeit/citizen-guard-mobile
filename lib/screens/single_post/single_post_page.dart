// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:diploma_citizen/data/constants/sized_boxes.dart';
import 'package:diploma_citizen/data/constants/texts.dart';
import 'package:diploma_citizen/data/models/single_post_model.dart';

import '../../data/constants/colors.dart';
import '../../data/constants/textStyles.dart';
import 'get_single_post_bloc/get_single_post_bloc.dart';
import 'patch_status_bloc/patch_status_bloc.dart';

class SinglePostPage extends StatefulWidget {
  const SinglePostPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

var userTypeBox = Hive.box('userType');
bool _isUser = true;

int _indexStatus = -1;
var boxDecoration = BoxDecoration(
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

class _SinglePostPageState extends State<SinglePostPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isUser = userTypeBox.get('key') == 'ROLE_USER';
    context.read<GetSinglePostBloc>().add(GetSinglePostEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<GetSinglePostBloc, GetSinglePostState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state is GetSinglePostSuccess
              ? appBar(state.spm.postNumber)
              : null,
          backgroundColor: white,
          body: SafeArea(
            child: state is GetSinglePostLaoding
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state is GetSinglePostSuccess
                    ? Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _isUser
                                      ? status_body(maxWidth, state)
                                      : SizedBox(),
                                  mainInfo(maxWidth, state.spm),
                                  sb_h8(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      1,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              barrierColor:
                                                  black0C.withOpacity(0.50),
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return
                                                    // AlertDialog(
                                                    //   content:
                                                    Stack(
                                                  alignment: Alignment.center,
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // SizedBox(
                                                        //   width: maxWidth,
                                                        //   height: 258,
                                                        //   child: Image(
                                                        //     image: AssetImage(
                                                        //       'assets/images/accident_image.png',
                                                        //     ),
                                                        //     fit: BoxFit.cover,
                                                        //     // ),
                                                        //   ),
                                                        // ),
                                                        CachedNetworkImage(
                                                          // imageUrl: "http://mvs.bslmeiyu.com/storage/profile"
                                                          //     "/2022-05-02-626fc39bf18a6.png",
                                                          imageUrl: state
                                                              .spm.urlToImage,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            height: 258,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: whitef8,
                                                              image:
                                                                  DecorationImage(
                                                                //image size fill
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          placeholder:
                                                              (context, url) =>
                                                                  Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child:
                                                                // Text(url),
                                                                CircularProgressIndicator(), // you can add pre loader iamge as well to show loading.
                                                          ), //show progress  while loading image
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Center(
                                                            child: Text(
                                                              'ERROR',
                                                              style:
                                                                  tsred_16_500,
                                                            ),
                                                          ),
                                                          // Image.asset("images/flutter.png"),
                                                          //show no image available image on error loading
                                                        )
                                                      ],
                                                    ),
                                                    Positioned(
                                                      right: 18,
                                                      top: (MediaQuery.of(context)
                                                                      .size
                                                                      .height -
                                                                  258) /
                                                              2 -
                                                          6,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: black0C
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                            width: (maxWidth - 32) / 2 - 15,
                                            height: (maxWidth - 32) / 2 - 15,
                                            decoration: boxDecorationImage,
                                            padding: EdgeInsets.all(8),
                                            child: CachedNetworkImage(
                                              // imageUrl: "http://mvs.bslmeiyu.com/storage/profile"
                                              //     "/2022-05-02-626fc39bf18a6.png",
                                              imageUrl: state.spm.urlToImage,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: (maxWidth - 32) / 2 -
                                                    15 -
                                                    16,
                                                height: (maxWidth - 32) / 2 -
                                                    15 -
                                                    16,
                                                decoration: BoxDecoration(
                                                  color: whitef8,
                                                  image: DecorationImage(
                                                    //image size fill
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                alignment: Alignment.center,
                                                child:
                                                    // Text(url),
                                                    CircularProgressIndicator(), // you can add pre loader iamge as well to show loading.
                                              ), //show progress  while loading image
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                child: Text(
                                                  'ERROR',
                                                  style: tsred_16_500,
                                                ),
                                              ),
                                              // Image.asset("images/flutter.png"),
                                              //show no image available image on error loading
                                            )
                                            //  Container(
                                            //   decoration: BoxDecoration(
                                            //     borderRadius:
                                            //         BorderRadius.circular(8),
                                            //     color: greyA8,
                                            //     image: DecorationImage(
                                            //       image: AssetImage(
                                            //         'assets/images/accident_image.png',
                                            //       ),
                                            //       fit: BoxFit.cover,
                                            //     ),
                                            //   ),
                                            //   // child: SvgPicture.asset(
                                            //   //   'assets/icons/accident_image.svg',
                                            //   //   fit: BoxFit.cover,
                                            //   // ),
                                            //   // child: Image(
                                            //   //   image: AssetImage(
                                            //   //     'assets/images/accident_image.png',
                                            //   //   ),
                                            //   //   fit: BoxFit.cover,
                                            //   // ),
                                            // ),
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          !_isUser
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Container(
                                    //   width: maxWidth - 32,
                                    //   padding: EdgeInsets.symmetric(
                                    //       horizontal: 16, vertical: 8),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius:
                                    //         BorderRadius.circular(100),
                                    //     color: orangeED,
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       SizedBox(
                                    //         width: maxWidth / 2,
                                    //         child: Text(
                                    //           // 'Under consideration',
                                    //           state.spm.status,
                                    //           style: tswh_12_500_20,
                                    //         ),
                                    //       ),
                                    //       Text(
                                    //         '01.01.2023 15:10',
                                    //         style: tswh_12_500_20,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    status_body(maxWidth, state),
                                    sb_h8(),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor:
                                              black0C.withOpacity(0),
                                          context: context,
                                          builder: (context) {
                                            return ModalBS(
                                              id: state.spm.id,
                                              callReset: () {
                                                context
                                                    .read<GetSinglePostBloc>()
                                                    .add(GetSinglePostEvent(
                                                        id: widget.id));
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        'Change status',
                                        style: tsbl_14_400_un,
                                      ),
                                    ),
                                    sb_h8(),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      )
                    : state is GetSinglePostFailure
                        ? Center(
                            child: Text(
                              'ERROR',
                              style: tsred_12_500,
                            ),
                          )
                        : SizedBox(),
          ),
        );
      },
    );
  }

  Container status_body(double maxWidth, GetSinglePostSuccess state) {
    return Container(
      width: maxWidth - 32,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: state.spm.status == statusList[1]
            ? orangeED
            : state.spm.status == statusList[2]
                ? greenAC
                : redF6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: maxWidth / 2,
            child: Text(
              // 'Under consideration',
              state.spm.status,
              style: tswh_12_500_20,
            ),
          ),
          Text(
            // '01.01.2023 15:10',
            // '${state.spm.date} ${state.spm.time}',
            state.spm.statusTime,
            style: tswh_12_500_20,
          ),
        ],
      ),
    );
  }

  Container mainInfo(double maxW, SinglePostModel spm) {
    return Container(
      width: double.infinity,
      // height: 300,
      padding: EdgeInsets.all(16),
      decoration: boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'City',
                style: ts0c_12_400,
              ),
              Text(
                // 'Almaty',
                spm.city,
                style: ts0c_12_600,
              ),
            ],
          ),
          div(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Distirct',
                style: ts0c_12_400,
              ),
              Text(
                // 'Bostandyksky',
                spm.distirct,
                style: ts0c_12_600,
              ),
            ],
          ),
          div(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date',
                style: ts0c_12_400,
              ),
              Text(
                // '25.03.2023',
                spm.date,
                style: ts0c_12_600,
              ),
            ],
          ),
          div(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time',
                style: ts0c_12_400,
              ),
              Text(
                // '13:30',
                spm.time,
                style: ts0c_12_600,
              ),
            ],
          ),
          div(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: ts0c_12_400,
              ),
              SizedBox(
                width: maxW - 64 - 82,
                child: Text(
                  // 'Loss of property and loss of a person',
                  spm.category,
                  textAlign: TextAlign.end,
                  style: ts0c_12_600,
                ),
              ),
            ],
          ),
          sb_h8(),
          div(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Applicant',
                style: ts0c_12_400,
              ),
              SizedBox(
                width: maxW - 64 - 82,
                child: Text(
                  // 'Loss of property and loss of a person',
                  spm.iinA,
                  textAlign: TextAlign.end,
                  style: ts0c_12_600,
                ),
              ),
            ],
          ),
          div(),
          sb_h8(),
          Text(
            'Description of the incident:',
            style: ts0c_12_400,
          ),
          sb_h8(),
          SizedBox(
            width: maxW - 64,
            child: Text(
              // 'something',
              spm.description,
              style: ts0c_12_600,
            ),
          ),
          div(),
          Text(
            'Additional information:',
            style: ts0c_12_400,
          ),
          sb_h8(),
          SizedBox(
            width: maxW - 64,
            child: Text(
              // 'something',
              spm.add_info,
              style: ts0c_12_600,
            ),
          ),
        ],
      ),
    );
  }

  Container div() {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      color: greyA8,
    );
  }

  AppBar appBar(String number) {
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
        '№$number',
        style: ts0c_16_500,
      ),
    );
  }
}

class ModalBS extends StatefulWidget {
  const ModalBS({
    Key? key,
    required this.id,
    required this.callReset,
  }) : super(key: key);
  final int id;
  final Function callReset;

  @override
  State<ModalBS> createState() => _ModalBSState();
}

class _ModalBSState extends State<ModalBS> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<PatchStatusBloc>().add(EmitInitial());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatchStatusBloc, PatchStatusState>(
      builder: (context, state) {
        if (state is PatchStatusSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context).pop();
            widget.callReset();
          });
          context.read<PatchStatusBloc>().add(EmitInitial());
        }
        return state is PatchStatusLoading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [CircularProgressIndicator()],
              )
            : state is PatchStatusFailure
                ? Container(
                    child: Text(
                      'ERROR',
                      style: tsred_12_500,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        // 20,
                        statusList.length - 1,
                        (index) => GestureDetector(
                          onTap: () {
                            // widget.stcityId(index);
                            setState(() {
                              _indexStatus = index;
                            });
                            context.read<PatchStatusBloc>().add(
                                PatchStatusEvent(
                                    widget.id, statusCodes[index]));
                            // Navigator.of(context).pop();
                            // widget.callReset();
                          },
                          child: Container(
                            color: _indexStatus != index ? whitef3 : blueD3,
                            margin: EdgeInsets.symmetric(vertical: 1),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 96,
                                  child: Text(
                                    statusList[index + 1],
                                    style: _indexStatus != index
                                        ? tsgr_12_400_24
                                        : tsbl_12_600_24,
                                  ),
                                ),
                                _indexStatus == index
                                    ? Icon(
                                        Icons.check,
                                        color: blue,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
