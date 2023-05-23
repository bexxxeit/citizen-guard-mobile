import 'package:bloc/bloc.dart';
import 'package:diploma_citizen/data/api/api_provider.dart';
import 'package:diploma_citizen/data/models/post_tile_model.dart';
import 'package:equatable/equatable.dart';

part 'get_user_posts_event.dart';
part 'get_user_posts_state.dart';

class GetUserPostsBloc extends Bloc<GetUserPostsEvent, GetUserPostsState> {
  ApiProvider _apiProvider = ApiProvider();
  GetUserPostsBloc() : super(GetUserPostsInitial()) {
    on<GetUserPosts>((event, emit) async {
      // TODO: implement event handler
      print('GET POSTS BLOC');
      print('${event.initDate} ${event.finDate}, ${event.category},'
          ' ${event.category}, ${event.city}, ${event.district}, '
          '${event.status}');
      emit(GetUserPostsLoading());
      try {
        List<PostTileModel>? posts = await _apiProvider.getPosts(
          event.initDate,
          event.finDate,
          event.category,
          event.status,
          event.city,
          event.district,
          '',
        );
        posts != null
            ? emit(GetUserPostsSuccess(posts: posts))
            : emit(GetUserPostsFailure());
      } catch (e) {
        print(e);
        print('ERROR IN CATCH GET POSTS');
        emit(GetUserPostsFailure());
      }
    });
  }
}
