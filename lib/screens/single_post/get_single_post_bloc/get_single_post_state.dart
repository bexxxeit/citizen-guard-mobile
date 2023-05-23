// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_single_post_bloc.dart';

abstract class GetSinglePostState extends Equatable {
  const GetSinglePostState();

  @override
  List<Object> get props => [];
}

class GetSinglePostInitial extends GetSinglePostState {}

class GetSinglePostLaoding extends GetSinglePostState {}

class GetSinglePostSuccess extends GetSinglePostState {
  final SinglePostModel spm;
  GetSinglePostSuccess({
    required this.spm,
  });

  @override
  List<Object> get props => [spm];
}

class GetSinglePostFailure extends GetSinglePostState {}
