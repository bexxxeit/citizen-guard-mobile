// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_cities_bloc.dart';

abstract class GetCitiesState extends Equatable {
  const GetCitiesState();

  @override
  List<Object> get props => [];
}

class GetCitiesInitial extends GetCitiesState {}

class GetCitiesLoading extends GetCitiesState {}

// ignore: must_be_immutable
class GetCitiesSuccess extends GetCitiesState {
  List<String> cities;
  GetCitiesSuccess({
    required this.cities,
  });

  @override
  List<Object> get props => [cities];
}

class GetCitiesFailure extends GetCitiesState {}
