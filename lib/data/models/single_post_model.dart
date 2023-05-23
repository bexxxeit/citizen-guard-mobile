// ignore_for_file: public_member_api_docs, sort_constructors_first
class SinglePostModel {
  int id;
  String postNumber;
  String city;
  String distirct;
  String date;
  String time;
  String category;
  String description;
  String add_info;
  String urlToImage;
  String status;
  String iinA;
  String statusTime;
  // Single
  SinglePostModel({
    required this.id,
    required this.postNumber,
    required this.city,
    required this.distirct,
    required this.date,
    required this.time,
    required this.category,
    required this.description,
    required this.add_info,
    required this.urlToImage,
    required this.status,
    required this.iinA,
    required this.statusTime,
  });

  @override
  String toString() {
    return 'SinglePostModel(postNumber: $postNumber, city: $city, distirct: $distirct, date: $date, time: $time, category: $category, description: $description, add_info: $add_info, urlToImage: $urlToImage, status: $status)';
  }
}
