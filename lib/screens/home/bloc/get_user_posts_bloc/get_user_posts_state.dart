// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_user_posts_bloc.dart';

abstract class GetUserPostsState extends Equatable {
  const GetUserPostsState();

  @override
  List<Object> get props => [];
}

class GetUserPostsInitial extends GetUserPostsState {}

class GetUserPostsLoading extends GetUserPostsState {}

class GetUserPostsSuccess extends GetUserPostsState {
  final List<PostTileModel> posts;
  GetUserPostsSuccess({
    required this.posts,
  });

  @override
  List<Object> get props => [posts];
}

class GetUserPostsFailure extends GetUserPostsState {}
