// // // ignore_for_file: public_member_api_docs, sort_constructors_first
// // // ignore_for_file: prefer_const_constructors

// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// // import 'package:diploma_citizen/data/constants/textStyles.dart';
// // import 'package:diploma_citizen/data/constants/texts.dart';
// // import 'package:diploma_citizen/data/models/user_model.dart';
// // import 'package:diploma_citizen/screens/home/home_page.dart';

// // import '../../../data/constants/colors.dart';
// // import '../../../data/constants/sized_boxes.dart';
// // import 'get_cities_bloc/get_cities_bloc.dart';

// // int _cityId = -1;

// // class ListCitiesBody extends StatefulWidget {
// //   const ListCitiesBody({
// //     Key? key,
// //     required this.stcityId,
// //     required this.scrollController,
// //     required this.title,
// //     required this.close,
// //     required this.isCity,
// //     required this.isCategory,
// //   }) : super(key: key);
// //   final Function stcityId;
// //   final ScrollController scrollController;
// //   final String title;
// //   final Function close;
// //   final bool isCity;
// //   final bool isCategory;

// //   @override
// //   State<ListCitiesBody> createState() => _ListCitiesBodyState();
// // }

// // class _ListCitiesBodyState extends State<ListCitiesBody> {
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     context.read<GetCitiesBloc>().add(GetCitiesEvent());
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<GetCitiesBloc, GetCitiesState>(
// //       builder: (context, state) {
// //         return Container(
// //           margin: EdgeInsets.only(top: AppBar().preferredSize.height - 20),
// //           padding: EdgeInsets.all(12),
// //           height: MediaQuery.of(context).size.height -
// //               AppBar().preferredSize.height +
// //               20,
// //           decoration: BoxDecoration(
// //             color: white,
// //             borderRadius: BorderRadius.vertical(
// //               top: Radius.circular(16),
// //             ),
// //           ),
// //           child: SingleChildScrollView(
// //             controller: widget.scrollController,
// //             child: Column(
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Text(
// //                       // 'Choose city',
// //                       widget.title,
// //                       style: ts0c_16_500,
// //                     ),
// //                     SizedBox(),
// //                     // GestureDetector(
// //                     //   onTap: () {
// //                     //     Navigator.of(context).pop();
// //                     //   },
// //                     //   child: Container(
// //                     //     decoration: BoxDecoration(
// //                     //       color: greyA8,
// //                     //       shape: BoxShape.circle,
// //                     //     ),
// //                     //     child: Icon(
// //                     //       Icons.close,
// //                     //       color: white,
// //                     //       size: 20,
// //                     //     ),
// //                     //   ),
// //                     // )
// //                   ],
// //                 ),
// //                 sb_h10(),
// //                 state is GetCitiesLoading
// //                     ? SizedBox(
// //                         height: 100,
// //                         child: Column(
// //                           children: [
// //                             CircularProgressIndicator(),
// //                           ],
// //                         ),
// //                       )
// //                     : state is GetCitiesSuccess
// //                         ? SingleChildScrollView(
// //                             child: Column(
// //                               children: List.generate(
// //                                 // citiesList.length,
// //                                 state.cities.length,
// //                                 (index) => GestureDetector(
// //                                   onTap: () {
// //                                     // widget.stcityId(index);
// //                                     widget.stcityId(state.cities[index]);
// //                                     setState(() {
// //                                       _cityId = index;
// //                                     });
// //                                   },
// //                                   child: Container(
// //                                     color: _cityId != index ? whitef3 : blueD3,
// //                                     margin: EdgeInsets.symmetric(vertical: 1),
// //                                     padding: EdgeInsets.symmetric(
// //                                         horizontal: 16, vertical: 12),
// //                                     child: Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       children: [
// //                                         Text(
// //                                           // citiesList[index],
// //                                           state.cities[index],
// //                                           style: _cityId != index
// //                                               ? tsgr_12_400
// //                                               : tsbl_12_600,
// //                                         ),
// //                                         _cityId == index
// //                                             ? Icon(
// //                                                 Icons.check,
// //                                                 color: blue,
// //                                               )
// //                                             : SizedBox(),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           )
// //                         : state is GetCitiesFailure
// //                             ? SizedBox(
// //                                 height: 100,
// //                                 child: Text(
// //                                   'ERROR',
// //                                   style: tsred_12_500,
// //                                 ),
// //                               )
// //                             : SizedBox(),
// //                 // ListView.builder(
// //                 //   controller: scrollController,
// //                 //   itemCount: 25,
// //                 //   itemBuilder: (BuildContext context, int index) {
// //                 //     return ListTile(
// //                 //       title: Text('Item $index'),
// //                 //       onTap: () {
// //                 //         stcityId(index);
// //                 //       },
// //                 //     );
// //                 //   },
// //                 // ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:diploma_citizen/data/constants/colors.dart';
// import 'package:diploma_citizen/data/constants/sized_boxes.dart';
// import 'package:diploma_citizen/data/constants/textStyles.dart';

// int _index = -1;

// class ListStatusBody extends StatefulWidget {
//   const ListStatusBody({
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
//   State<ListStatusBody> createState() => _ListStatusBodyState();
// }

// class _ListStatusBodyState extends State<ListStatusBody> {
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
