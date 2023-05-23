import 'package:intl/intl.dart';

import '../models/post_tile_model.dart';

List<PostTileModel> listPostTiles = [
  PostTileModel(
    id: 1,
    number: '123456789',
    status: 2,
    title: 'title 1',
    postDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
  ),
  PostTileModel(
    id: 2,
    number: '456879123',
    status: 1,
    title: 'title 2',
    postDate: DateFormat('dd-MM-yyyy')
        .format(DateTime.now().subtract(Duration(days: 300))),
  ),
  PostTileModel(
    id: 3,
    number: '789456123',
    status: 3,
    title: 'title 3',
    postDate: DateFormat('dd-MM-yyyy')
        .format(DateTime.now().subtract(Duration(days: 700))),
  ),
  PostTileModel(
    id: 4,
    number: '147456789',
    status: 2,
    title: 'title 4',
    postDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
  ),
  PostTileModel(
    id: 5,
    number: '258456789',
    status: 2,
    title: 'title 5',
    postDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
  ),
  PostTileModel(
    id: 6,
    number: '369789456',
    status: 2,
    title: 'title 6',
    postDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
  ),
  PostTileModel(
    id: 7,
    number: '741654987',
    status: 1,
    title: 'title 7',
    postDate: DateFormat('dd-MM-yyyy')
        .format(DateTime.now().subtract(Duration(days: 300))),
  ),
  PostTileModel(
    id: 8,
    number: '852987321',
    status: 3,
    title: 'title 3',
    postDate: DateFormat('dd-MM-yyyy')
        .format(DateTime.now().subtract(Duration(days: 700))),
  ),
  PostTileModel(
    id: 9,
    number: '963987321',
    status: 2,
    title: 'title 9',
    postDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
  ),
  PostTileModel(
    id: 10,
    number: '753159456',
    status: 1,
    title: 'title 10',
    postDate: DateFormat('dd-MM-yyyy')
        .format(DateTime.now().subtract(Duration(days: 300))),
  ),
  PostTileModel(
    id: 11,
    number: '159357258',
    status: 3,
    title: 'title 11',
    postDate: DateFormat('dd-MM-yyyy')
        .format(DateTime.now().subtract(Duration(days: 700))),
  ),
];
