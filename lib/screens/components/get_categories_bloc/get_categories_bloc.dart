import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/api/api_provider.dart';
import '../../../data/models/category_tile_model.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  ApiProvider _apiProvider = ApiProvider();

  GetCategoriesBloc() : super(GetCategoriesInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      // TODO: implement event handler
      print('CATEGORIES BLOC');
      emit(GetCategoriesLoading());
      try {
        List<CategoryModel>? _categories = await _apiProvider.getCategories();
        print(_categories);
        _categories != null
            ? emit(GetCategoriesSuccess(categories: _categories))
            : emit(GetCategoriesFailure());
      } catch (e) {
        print('ERROR IN CATCH CATEGORIES');
        print(e);
        emit(GetCategoriesFailure());
      }
    });
  }
}
