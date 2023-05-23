// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostTileModel {
  int id;
  String number;
  int status;
  String title;
  // DateTime postDate;
  String postDate;
  PostTileModel({
    required this.id,
    required this.number,
    required this.status,
    required this.title,
    required this.postDate,
  });

  @override
  String toString() {
    return 'PostTileModel(id: $id, number: $number, status: $status, title: $title, postDate: $postDate)';
  }
}
