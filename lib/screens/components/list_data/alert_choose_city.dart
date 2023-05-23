// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../data/constants/sized_boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/constants/colors.dart';

import '../../../data/constants/textStyles.dart';
import '../../auth/other_pages/get_cities_bloc/get_cities_bloc.dart';

int selectedRadioTile = -1;
ScrollController scrollController = ScrollController();

int _selectedRCId = -1;
String _selectedRCName = '';
// List<CityModel> _listCities = [];

class AlertSetRegionCity extends StatefulWidget {
  const AlertSetRegionCity({
    Key? key,
    required this.stcityId,
    // required this.scrollController,
    required this.title,
    required this.close,
    required this.isCity,
    required this.cityName,
  }) : super(key: key);
  final Function stcityId;
  // final ScrollController scrollController;
  final String title;
  final Function close;
  final bool isCity;
  final String cityName;

  @override
  State<AlertSetRegionCity> createState() => _AlertSetRegionCityState();
}

class _AlertSetRegionCityState extends State<AlertSetRegionCity> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadioTile = -1;
    context.read<GetCitiesBloc>().add(
        widget.isCity ? GetCitiesEvent() : GetDistirctsEvent(widget.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCitiesBloc, GetCitiesState>(
      builder: (context, state) {
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
          content: state is GetCitiesLoading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    sb_h32(),
                    sb_h32(),
                    SizedBox(
                      width: double.infinity,
                    ),
                    CircularProgressIndicator(),
                    sb_h32(),
                    sb_h32(),
                  ],
                )
              : state is GetCitiesSuccess
                  ? alertContent(state.cities
                      // widget.isRegion
                      //     ? ([
                      //           RegionModel(
                      //             idRegion: 0,
                      //             nameRegion: 'Все регионы',
                      //             cities: widget.cities,
                      //           ),
                      //         ] +
                      //         state.listRegions)
                      //     : [
                      //         RegionModel(
                      //           idRegion: 0,
                      //           nameRegion: 'nameRegion',
                      //           cities: ([
                      //                 CityModel(idCity: 0, name: 'Все города')
                      //               ] +
                      //               widget.cities),
                      //         ),
                      //       ],
                      )
                  : state is GetCitiesFailure
                      ? Column(
                          children: [
                            sb_h32(),
                            sb_h32(),
                            SizedBox(
                              width: double.infinity,
                            ),
                            Text(
                              'ERROR',
                              style: tsred_12_500,
                              textAlign: TextAlign.center,
                            ),
                            sb_h32(),
                            sb_h32(),
                          ],
                        )
                      : const SizedBox(),
        );
      },
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
        widget.stcityId(_selectedRCName);
        Navigator.of(context).pop();

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
