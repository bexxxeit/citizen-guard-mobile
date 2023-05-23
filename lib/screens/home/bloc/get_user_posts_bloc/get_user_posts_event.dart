// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_user_posts_bloc.dart';

abstract class GetUserPostsEvent extends Equatable {
  const GetUserPostsEvent();

  // @override
  // List<Object> get props => [];
}

class GetUserPosts extends GetUserPostsEvent {
  final String initDate;
  final String finDate;
  final String category;
  final String status;
  final String city;
  final String district;
  const GetUserPosts({
    required this.initDate,
    required this.finDate,
    required this.category,
    required this.status,
    required this.city,
    required this.district,
  });
  @override
  List<Object> get props =>
      [initDate, finDate, category, status, city, district];
}
