part of 'get_search_posts_bloc.dart';

abstract class GetSearchPostsState extends Equatable {
  const GetSearchPostsState();

  @override
  List<Object> get props => [];
}

class GetUserPostsInitial extends GetSearchPostsState {}

class GetUserPostsLoading extends GetSearchPostsState {}

class GetUserPostsSuccess extends GetSearchPostsState {
  final List<PostTileModel> posts;
  GetUserPostsSuccess({
    required this.posts,
  });

  @override
  List<Object> get props => [posts];
}

class GetUserPostsFailure extends GetSearchPostsState {}
