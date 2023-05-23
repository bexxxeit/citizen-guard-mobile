// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../data/constants/colors.dart';

import '../../../data/constants/textStyles.dart';

int selectedRadioTile = -1;
ScrollController scrollController = ScrollController();

int _selectedRCId = -1;
String _selectedRCName = '';
// List<CityModel> _listCities = [];

class AlertSetStatus extends StatefulWidget {
  const AlertSetStatus({
    Key? key,
    required this.stcityId,
    // required this.scrollController,
    required this.listData,
    required this.title,
    required this.close,
  }) : super(key: key);
  final Function stcityId;
  // final ScrollController scrollController;
  final List<String> listData;
  final String title;
  final Function close;

  @override
  State<AlertSetStatus> createState() => _AlertSetStatusState();
}

class _AlertSetStatusState extends State<AlertSetStatus> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadioTile = -1;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide.none,
      ),
      backgroundColor: white,
      insetPadding: const EdgeInsets.all(10),
      titlePadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      title: topBody(),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      content: alertContent(widget.listData),
    );
  }

  Container alertContent(List<String> listData) {
    return Container(
      width: MediaQuery.of(context).size.width - 24,
      height: MediaQuery.of(context).size.height / 2 - 24,
      // padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // topBody(context),
          // SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2 - 95,
            child: ListView(
              padding: EdgeInsets.zero,
              controller: scrollController,
              scrollDirection: Axis.vertical,
              children: List.generate(
                // listData.length,
                listData.length,
                (index) => Container(
                  // width: double.infinity,
                  width: MediaQuery.of(context).size.width - 15,
                  margin: EdgeInsets.only(top: 8),
                  height: 48,
                  // padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: selectedRadioTile != index ? whitef3 : blueD3),
                  child: RadioListTile(
                    value: index,
                    groupValue: selectedRadioTile,
                    toggleable: true,
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(
                      // namesSura[index] as String,
                      listData[index],
                      style: selectedRadioTile != index
                          ? tsgr_12_400
                          : tsbl_12_600,
                    ),
                    onChanged: (val) {
                      if (selectedRadioTile != index) {
                        // if (selectedRadioTile_Slug != listCities[index].slug) {
                        // print('Current Location '
                        // '${widget.isRegion ? listData[index].nameRegion : listData[0].cities[index]}');

                        // setSelectedRadioTile(listCities[index].slug);
                        setState(() {
                          selectedRadioTile = index;
                        });
                        setSelectedRadioTile(listData[index]
                            // index,
                            // widget.isRegion
                            //     ? listData[index].idRegion
                            //     : listData[0].cities[index].idCity,
                            // widget.isRegion
                            //     ? listData[index].nameRegion
                            //     : listData[0].cities[index].name,
                            // widget.isRegion ? listData[index].cities : [],
                            );
                      }
                    },
                    selected: selectedRadioTile == index,
                    // selected: selectedRadioTile_Slug
                    //     .endsWith(listCities[index].slug),
                    // activeColor: Colors.black,
                    activeColor: blue,
                    // selectedTileColor: Color(0xff2DC36A),
                  ),
                ),
              ),
            ),
          ),
          button(selectedRadioTile),
        ],
      ),
    );
  }

  setSelectedRadioTile(String name) {
    setState(() {
      _selectedRCName = name;
    });
  }

  Widget button(int index) {
    return InkWell(
      onTap: () {
        // widget.setSelectedCityRegionId(
        //   _selectedRCId,
        //   _selectedRCName,
        // );
        // widget.isRegion ? widget.setListCities(_listCities) : null;
        widget.stcityId(selectedRadioTile);
        // Navigator.of(context).pop();

        // if (userCityBox.isNotEmpty) {
        //   print(userCityBox.getAt(0).toString());
        //   userCityBox.putAt(0, cityModel);
        // } else {
        //   userCityBox.add(cityModel);
        // }
        // if (widget.stMainPage != null) {
        //   widget.stMainPage!();
        //   Navigator.of(context).pop();
        // } else {
        //   Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const HomePage(),
        //     ),
        //     (Route<dynamic> route) => false,
        //   );
        // }
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          'Выбрать',
          style: tswh_16_400,
        ),
      ),
    );
  }

  Widget topBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 80,
          child: Text(
            widget.title,
            style: ts0c_16_500,
            // maxLines: 2,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: CircleAvatar(
            radius: 12,
            backgroundColor: grey75,
            child: Icon(
              Icons.close,
              color: white,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
