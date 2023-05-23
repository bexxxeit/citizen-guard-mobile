// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:diploma_citizen/data/constants/colors.dart';
import 'package:diploma_citizen/data/constants/sized_boxes.dart';
import 'package:diploma_citizen/data/constants/textStyles.dart';
import 'package:diploma_citizen/data/models/add_post_type_model.dart';
import 'package:diploma_citizen/screens/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_post_bloc/add_post_bloc.dart';

bool _isChecked = false;

class AlertPage extends StatefulWidget {
  const AlertPage({
    Key? key,
    required this.apm,
  }) : super(key: key);
  final AddPostModel apm;

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.apm);
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AddPostBloc, AddPostState>(
      builder: (context, state) {
        if (state is AddPostSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          });
        }
        return Scaffold(
          backgroundColor: white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SafeArea(
            child: GestureDetector(
              onTap: () {
                // setState(() {
                //   _pageIndex != 2 ? _pageIndex++ : null;
                // });
                _isChecked
                    ? context.read<AddPostBloc>().add(AddPostEvent(widget.apm))
                    : null;
              },
              child: Container(
                width: maxWidth - 32,
                height: 44,
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _isChecked ? blue : greyEF,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Send',
                  style: _isChecked ? tswh_12_400 : tsgr_12_400,
                ),
              ),
            ),
          ),
          body: Center(
            child: state is AddPostLoading
                ? CircularProgressIndicator()
                : state is AddPostFailure
                    ? SizedBox(
                        child: Text(
                          'ERROR',
                          style: tsred_12_500,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: blueD3,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: blue,
                            ),
                            sb_h16(),
                            Text(
                              'Attention!',
                              style: tsbl_14_600,
                            ),
                            sb_h16(),
                            Text(
                              'A very serious text for a user who says that he'
                              ' would be responsible and that\'s it',
                              textAlign: TextAlign.center,
                              style: tsbl_12_400,
                            ),
                            sb_h16(),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: greyA8,
                            ),
                            sb_h16(),
                            Row(
                              children: [
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                  },
                                  activeColor: blue,
                                  checkColor: white,
                                  fillColor: MaterialStateProperty.all(blue),
                                ),
                                sb_w4(),
                                SizedBox(
                                  width: maxWidth - 100,
                                  child: Text(
                                    'On liability for deliberately '
                                    'false denunciation under Art. 419 of the '
                                    'Criminal Code of the Republic of Kazakhstan'
                                    ' I know',
                                    style: tsbl_12_400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
          ),
        );
      },
    );
  }
}
