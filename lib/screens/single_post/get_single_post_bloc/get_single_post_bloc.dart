import 'package:bloc/bloc.dart';
import 'package:diploma_citizen/data/api/api_provider.dart';
import 'package:diploma_citizen/data/models/single_post_model.dart';
import 'package:equatable/equatable.dart';

part 'get_single_post_event.dart';
part 'get_single_post_state.dart';

class GetSinglePostBloc extends Bloc<GetSinglePostEvent, GetSinglePostState> {
  ApiProvider _apiProvider = ApiProvider();
  GetSinglePostBloc() : super(GetSinglePostInitial()) {
    on<GetSinglePostEvent>((event, emit) async {
      // TODO: implement event handler
      emit(GetSinglePostLaoding());
      print('GET SINGLE POST');
      try {
        SinglePostModel? spm = await _apiProvider.getSinglePost(event.id);
        spm != null
            ? emit(GetSinglePostSuccess(spm: spm))
            : emit(GetSinglePostFailure());
      } catch (e) {
        print(e);
        print('ERROR IN CATCH GET SINGLE POST');
        emit(GetSinglePostFailure());
      }
    });
  }
}
