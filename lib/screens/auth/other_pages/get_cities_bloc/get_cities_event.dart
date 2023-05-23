// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_cities_bloc.dart';

abstract class GetDataEvent extends Equatable {
  const GetDataEvent();

  @override
  List<Object> get props => [];
}

class GetCitiesEvent extends GetDataEvent {
  const GetCitiesEvent();

  @override
  List<Object> get props => [];
}

class GetDistirctsEvent extends GetDataEvent {
  const GetDistirctsEvent(
    this.cityName,
  );
  final String cityName;
  @override
  List<Object> get props => [cityName];
}
