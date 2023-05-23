import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreatePostJsonModel {
  String city;
  String district;
  String incidentTime;
  String category;
  String description;
  String additionalInfo;
  CreatePostJsonModel({
    required this.city,
    required this.district,
    required this.incidentTime,
    required this.category,
    required this.description,
    required this.additionalInfo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'district': district,
      'incidentTime': incidentTime,
      'category': category,
      'description': description,
      'additionalInfo': additionalInfo,
    };
  }

  factory CreatePostJsonModel.fromMap(Map<String, dynamic> map) {
    return CreatePostJsonModel(
      city: map['city'] as String,
      district: map['district'] as String,
      incidentTime: map['incidentTime'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      additionalInfo: map['additionalInfo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePostJsonModel.fromJson(String source) =>
      CreatePostJsonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '{\n'
        'city: $city,\n'
        'district: $district,\n'
        'incidentTime: $incidentTime,\n'
        'category: $category,\n'
        'description: $description,\n'
        'additionalInfo: $additionalInfo\n'
        '}';
  }
}
