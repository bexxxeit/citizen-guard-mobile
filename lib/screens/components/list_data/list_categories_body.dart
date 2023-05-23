// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// import 'package:diploma_citizen/data/constants/textStyles.dart';
// import 'package:diploma_citizen/data/constants/texts.dart';
// import 'package:diploma_citizen/data/models/user_model.dart';
// import 'package:diploma_citizen/screens/home/home_page.dart';

// import '../../../data/constants/colors.dart';
// import '../../../data/constants/sized_boxes.dart';
// // import '../../auth/other_pages/get_cities_bloc/get_cities_bloc.dart';
// import '../get_categories_bloc/get_categories_bloc.dart';

// int _ccategoryId = -1;

// class ListCategoriesBody extends StatefulWidget {
//   const ListCategoriesBody({
//     Key? key,
//     required this.stcityId,
//     required this.scrollController,
//     required this.title,
//     required this.close,
//   }) : super(key: key);
//   final Function stcityId;
//   final ScrollController scrollController;
//   final String title;
//   final Function close;

//   @override
//   State<ListCategoriesBody> createState() => _ListCategoriesBodyState();
// }

// class _ListCategoriesBodyState extends State<ListCategoriesBody> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context.read<GetCategoriesBloc>().add(GetCategoriesEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
//       builder: (context, state) {
//         return Container(
//           margin: EdgeInsets.only(top: AppBar().preferredSize.height - 20),
//           padding: EdgeInsets.all(12),
//           height: MediaQuery.of(context).size.height -
//               AppBar().preferredSize.height +
//               20,
//           decoration: BoxDecoration(
//             color: white,
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(16),
//             ),
//           ),
//           child: SingleChildScrollView(
//             controller: widget.scrollController,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       // 'Choose city',
//                       widget.title,
//                       style: ts0c_16_500,
//                     ),
//                     SizedBox(),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     Navigator.of(context).pop();
//                     //   },
//                     //   child: Container(
//                     //     decoration: BoxDecoration(
//                     //       color: greyA8,
//                     //       shape: BoxShape.circle,
//                     //     ),
//                     //     child: Icon(
//                     //       Icons.close,
//                     //       color: white,
//                     //       size: 20,
//                     //     ),
//                     //   ),
//                     // )
//                   ],
//                 ),
//                 sb_h10(),
//                 state is GetCategoriesLoading
//                     ? SizedBox(
//                         height: 100,
//                         child: Column(
//                           children: [
//                             CircularProgressIndicator(),
//                           ],
//                         ),
//                       )
//                     : state is GetCategoriesSuccess
//                         ? SingleChildScrollView(
//                             child: Column(
//                               children: List.generate(
//                                 // citiesList.length,
//                                 state.categories.length,
//                                 (index) => GestureDetector(
//                                   onTap: () {
//                                     // widget.stcityId(index);
//                                     widget.stcityId(
//                                         state.categories[index].name,
//                                         state.categories[index].code);
//                                     setState(() {
//                                       _ccategoryId = index;
//                                     });
//                                   },
//                                   child: Container(
//                                     color: _ccategoryId != index
//                                         ? whitef3
//                                         : blueD3,
//                                     margin: EdgeInsets.symmetric(vertical: 1),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 16, vertical: 12),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         SizedBox(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width -
//                                               32 -
//                                               24 -
//                                               24,
//                                           child: Text(
//                                             // citiesList[index],
//                                             state.categories[index].name,
//                                             style: _ccategoryId != index
//                                                 ? tsgr_12_400
//                                                 : tsbl_12_600,
//                                           ),
//                                         ),
//                                         _ccategoryId == index
//                                             ? Icon(
//                                                 Icons.check,
//                                                 color: blue,
//                                               )
//                                             : SizedBox(),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         : state is GetCategoriesFailure
//                             ? SizedBox(
//                                 height: 100,
//                                 child: Text(
//                                   'ERROR',
//                                   style: tsred_12_500,
//                                 ),
//                               )
//                             : SizedBox(),
//                 // ListView.builder(
//                 //   controller: scrollController,
//                 //   itemCount: 25,
//                 //   itemBuilder: (BuildContext context, int index) {
//                 //     return ListTile(
//                 //       title: Text('Item $index'),
//                 //       onTap: () {
//                 //         stcityId(index);
//                 //       },
//                 //     );
//                 //   },
//                 // ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
