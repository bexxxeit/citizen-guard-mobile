// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_search_posts_bloc.dart';

abstract class GetSearchPostsEvent extends Equatable {
  const GetSearchPostsEvent();

  @override
  List<Object> get props => [];
}

class GetUserPosts extends GetSearchPostsEvent {
  final String initDate;
  final String finDate;
  final String category;
  final String status;
  final String city;
  final String district;
  final String number;
  const GetUserPosts({
    required this.initDate,
    required this.finDate,
    required this.category,
    required this.status,
    required this.city,
    required this.district,
    required this.number,
  });
  @override
  List<Object> get props =>
      [initDate, finDate, category, status, city, district, number];
}

class GetUserPostsEmit extends GetSearchPostsEvent {}
