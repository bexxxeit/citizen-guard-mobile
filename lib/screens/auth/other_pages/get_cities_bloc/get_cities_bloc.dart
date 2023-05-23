import 'package:bloc/bloc.dart';
import 'package:diploma_citizen/data/api/api_provider.dart';
import 'package:equatable/equatable.dart';

part 'get_cities_event.dart';
part 'get_cities_state.dart';

class GetCitiesBloc extends Bloc<GetDataEvent, GetCitiesState> {
  ApiProvider _apiProvider = ApiProvider();
  GetCitiesBloc() : super(GetCitiesInitial()) {
    on<GetCitiesEvent>((event, emit) async {
      // TODO: implement event handler
      print('CITIES BLOC');
      emit(GetCitiesLoading());
      try {
        List<String>? cities = await _apiProvider.getCities();
        print(cities);
        cities != null
            ? emit(GetCitiesSuccess(cities: cities))
            : emit(GetCitiesFailure());
      } catch (e) {
        print('ERROR IN CATCH CITIES');
        print(e);
        emit(GetCitiesFailure());
      }
    });

    on<GetDistirctsEvent>((event, emit) async {
      // TODO: implement event handler
      print('CITIES BLOC');
      emit(GetCitiesLoading());
      try {
        List<String>? cities = await _apiProvider.getDistircts(event.cityName);
        print(cities);
        cities != null
            ? emit(GetCitiesSuccess(cities: cities))
            : emit(GetCitiesFailure());
      } catch (e) {
        print('ERROR IN CATCH CITIES');
        print(e);
        emit(GetCitiesFailure());
      }
    });
  }
}
