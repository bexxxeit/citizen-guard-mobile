// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class AddPostModel {
  String city;
  String distirct;
  String time;
  String category;
  String description;
  String addInfo;
  File imagePath;
  AddPostModel({
    required this.city,
    required this.distirct,
    required this.time,
    required this.category,
    required this.description,
    required this.addInfo,
    required this.imagePath,
  });

  @override
  String toString() {
    return 'AddPostModel(city: $city, distirct: $distirct, time: $time, category: $category, description: $description, addInfo: $addInfo, imagePath: $imagePath)';
  }
}
