import 'package:bloc/bloc.dart';
import 'package:diploma_citizen/data/api/api_provider.dart';
import 'package:diploma_citizen/data/models/add_post_type_model.dart';
import 'package:equatable/equatable.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  ApiProvider _apiProvider = ApiProvider();
  AddPostBloc() : super(AddPostInitial()) {
    on<AddPostEvent>((event, emit) async {
      // TODO: implement event handler
      //eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIwMjA1MDI1NzA2NTA
      //iLCJhdXRob3JpdGllcyI6W3siYXV0aG9yaXR5IjoiUk9MRV9VU
      //0VSIn1dLCJpYXQiOjE2ODE4OTkwMzMsImV4cCI6MTY4MTkwMjYzM30.
      //GTdeDjSPW3bsKm1ssi7Z3n-HJhHZ16HbFyZAWLCP5jY
      print('ADD POST');
      emit(AddPostLoading());
      try {
        await _apiProvider.addPost(event.addPostModel)
            ? emit(AddPostSuccess())
            : emit(AddPostFailure());
      } catch (e) {
        print(e);
        print('ERROR IN CATCH');
        emit(AddPostFailure());
      }
    });
  }
}
