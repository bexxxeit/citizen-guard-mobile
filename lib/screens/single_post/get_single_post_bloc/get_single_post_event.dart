// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_single_post_bloc.dart';

// ignore: must_be_immutable
class GetSinglePostEvent extends Equatable {
  int id;
  GetSinglePostEvent({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}
