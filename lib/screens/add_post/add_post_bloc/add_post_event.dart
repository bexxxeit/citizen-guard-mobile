// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_post_bloc.dart';

class AddPostEvent extends Equatable {
  const AddPostEvent(
    this.addPostModel,
  );
  final AddPostModel addPostModel;

  @override
  List<Object> get props => [addPostModel];
}
