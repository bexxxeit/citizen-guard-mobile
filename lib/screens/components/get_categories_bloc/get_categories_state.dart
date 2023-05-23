// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_categories_bloc.dart';

abstract class GetCategoriesState extends Equatable {
  const GetCategoriesState();

  @override
  List<Object> get props => [];
}

class GetCategoriesInitial extends GetCategoriesState {}

class GetCategoriesLoading extends GetCategoriesState {}

class GetCategoriesSuccess extends GetCategoriesState {
  final List<CategoryModel> categories;
  GetCategoriesSuccess({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];
}

class GetCategoriesFailure extends GetCategoriesState {}
