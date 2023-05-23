import 'package:bloc/bloc.dart';
import 'package:diploma_citizen/data/api/api_provider.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/post_tile_model.dart';

part 'get_search_posts_event.dart';
part 'get_search_posts_state.dart';

class GetSearchPostsBloc
    extends Bloc<GetSearchPostsEvent, GetSearchPostsState> {
  ApiProvider _apiProvider = ApiProvider();
  GetSearchPostsBloc() : super(GetUserPostsInitial()) {
    on<GetUserPosts>((event, emit) async {
      // TODO: implement event handler
      print('GET POSTS BLOC');
      emit(GetUserPostsLoading());
      try {
        List<PostTileModel>? posts = await _apiProvider.getPosts(
            event.initDate,
            event.finDate,
            event.category,
            event.status,
            event.city,
            event.district,
            event.number);
        posts != null
            ? emit(GetUserPostsSuccess(posts: posts))
            : emit(GetUserPostsFailure());
      } catch (e) {
        print(e);
        print('ERROR IN CATCH GET POSTS');
        emit(GetUserPostsFailure());
      }
    });
    on<GetUserPostsEmit>((event, emit) => emit(GetUserPostsInitial()));
  }
}
