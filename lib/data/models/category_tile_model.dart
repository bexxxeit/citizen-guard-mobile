// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  String name;
  String code;
  CategoryModel({
    required this.name,
    required this.code,
  });

  @override
  String toString() => 'CategoryModel(name: $name, code: $code)';
}
