import 'dart:convert';

import 'package:diploma_citizen/data/constants/texts.dart';
import 'package:diploma_citizen/data/models/add_post_type_model.dart';
import 'package:diploma_citizen/data/models/category_tile_model.dart';
import 'package:diploma_citizen/data/models/post_tile_model.dart';
import 'package:diploma_citizen/data/models/single_post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../models/user_type_model.dart';

String baseUrl = 'http://194.110.55.6:8080/api/';

class ApiProvider {
  static final ApiProvider _singleton = ApiProvider._internal();

  factory ApiProvider() {
    return _singleton;
  }

  ApiProvider._internal();

  var tokenBox = Hive.box('tokens');
  var userTypeBox = Hive.box('userType');

  Future<bool> login(String iin, String password) async {
    print('LOGIN API');
    print(iin);
    print(password);
    final response = await http.post(
      Uri.parse(baseUrl + 'auth/login'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "username": iin,
          'password': password,
        },
      ),
    );
    print(response.body);
    print(response.statusCode);
    String token = jsonDecode(response.body)['token'];
    tokenBox.put('token', token);
    return response.statusCode == 200;
  }

  Future<bool> register(RegistrationUserModel userModel) async {
    print('REGISTER API');
    final response = await http.post(
      Uri.parse(baseUrl + 'auth/register'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "firstname": userModel.firstName,
          "lastname": userModel.lastName,
          "midname": userModel.middleName,
          "username": userModel.iin,
          "phoneNumber": userModel.phoneNumber,
          "city": userModel.cityName,
          // "distirct": userModel.cityName,
          "address": userModel.address,
          'password': userModel.password,
          'role': 'ROLE_USER',
        },
      ),
    );
    print(response.body);
    print(response.statusCode);
    String token = jsonDecode(response.body)['token'];
    tokenBox.put('token', token);
    return response.statusCode == 200;
  }

  Future<List<CategoryModel>?> getCategories() async {
    List<CategoryModel> _categories = [];
    print('GET CATEGORIES API');
    String token = tokenBox.get('token');
    final response = await http.get(
      Uri.parse(baseUrl + 'post_categories'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> citiesData = jsonDecode(response.body);
      for (var e in citiesData) {
        _categories.add(CategoryModel(name: e['name'], code: e['code']));
      }
      return _categories;
    }
    return null;
  }

  Future<List<String>?> getDistircts(String cityName) async {
    List<String> _cities = [];
    print('GET DISCTRICTS API $cityName');
    final response = await http.get(
      Uri.parse(baseUrl + 'districts/$cityName'),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> citiesData = jsonDecode(response.body);
      for (var e in citiesData) {
        _cities.add(e['name']);
      }
      return _cities;
    }
    return null;
  }

  Future<List<String>?> getCities() async {
    List<String> _cities = [];
    print('GET CITIES API');
    final response = await http.get(
      Uri.parse(baseUrl + 'cities'),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> citiesData = jsonDecode(response.body);
      for (var e in citiesData) {
        _cities.add(e['name']);
      }
      return _cities;
    }
    return null;
  }

  Future<bool> setUserProfile(RegistrationUserModel rum) async {
    print('USER ME API');
    String token = tokenBox.get('token');
    print(rum);
    final response = await http.put(
      Uri.parse(baseUrl + 'users/profile'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(
        {
          'firstname': rum.firstName,
          'lastname': rum.lastName,
          'midname': rum.middleName,
          'phoneNumber': rum.phoneNumber,
          'city': rum.cityName,
          'address': rum.address,
        },
      ),
    );
    print(response.body);
    print(response.statusCode);

    return response.statusCode == 200;
  }

  Future<RegistrationUserModel?> getUserProfile() async {
    print('USER ME API');
    String token = tokenBox.get('token');
    final response = await http.get(
      Uri.parse(baseUrl + 'users/profile'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic dataU = jsonDecode(response.body);
      return RegistrationUserModel(
        firstName: dataU['firstname'],
        lastName: dataU['lastname'],
        middleName: dataU['midname'],
        iin: dataU['iin'],
        phoneNumber: dataU['phoneNumber'],
        address: dataU['address'],
        password: '',
        cityName: dataU['city'],
      );
    }
    return null;
  }

  Future<UserModel?> getUserMe() async {
    print('USER ME API');
    String token = tokenBox.get('token');
    final response = await http.get(
      Uri.parse(baseUrl + 'users/me'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic dataU = jsonDecode(response.body);
      userTypeBox.put('key', dataU['role']);
      return UserModel(
        name: dataU['firstName'],
        city: dataU['city'],
        role: dataU['role'],
        username: dataU['username'],
      );
    }
    return null;
  }

  Future<List<PostTileModel>?> getPosts(
      String initDate,
      String finDate,
      String category,
      String status,
      String city,
      String district,
      String number) async {
    print('GET POSTS API');
    String stat =
        status.isNotEmpty ? statusCodes[statusList.indexOf(status) - 1] : '';
    print(stat);
    print(
        '$initDate $finDate $status $category $city $district are requirements');
    String token = tokenBox.get('token');
    String request =
        initDate.isNotEmpty ? 'dateFrom=$initDate&dateTo=$finDate' : '';
    // request += (request.isEmpty & finDate.isEmpty ? '' : '&');
    request += finDate.isNotEmpty ? '&dateTo=$finDate' : '';
    // request += (request.isEmpty & category.isEmpty ? '&' : '');
    request += category.isNotEmpty ? '&category=$category' : '';
    // request += (request.isEmpty & status.isEmpty ? '' : '&');
    request += status.isNotEmpty ? '&status=$stat' : '';
    // request += (request.isEmpty & city.isEmpty ? '' : '&');
    request += city.isNotEmpty ? '&city=$city' : '';
    // request += (request.isEmpty & district.isEmpty ? '' : '&');
    request += district.isNotEmpty ? '&district=$district' : '';
    // request += (request.isEmpty & number.isEmpty ? '' : '&');
    request += number.isNotEmpty ? '&query=$number' : '';
    print(request);
    final response = await http.get(
      Uri.parse(baseUrl + 'posts?' + request),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<PostTileModel> posts = [];
      // dynamic data = response.body;
      List<dynamic> postsData = jsonDecode(response.body);
      for (var e in postsData) {
        // print('for');
        // int id = int.parse(e['id']?? '-1') ;
        int id = e['id'] ?? -1;
        // print('id true');
        String postNumber = e['postNumber'] ?? 'NULL ERROR';
        // print('postnumber true');
        String status = e['status'] ?? 'NULL ERROR';
        print(status);
        // print('status true');
        String incidentTime = e['incidentTime'] ?? 'NULL ERROR';
        // print('time true');
        // String city = e['city'];
        // String distirct = e['district'];
        String category = e['category'] ?? 'NULL ERROR';
        // print('category true');

        posts.add(
          PostTileModel(
            id: id,
            number: postNumber.substring(4),
            status: statusList.indexOf(status),
            // title: 'NULL ERROR',
            title: category,
            postDate: incidentTime,
          ),
        );
      }
      print(posts);
      return posts;
    }
    return null;
  }

  Future<SinglePostModel?> getSinglePost(int id) async {
    print('GET POSTS API');
    String token = tokenBox.get('token');
    final response = await http.get(
      Uri.parse(baseUrl + 'posts/$id'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic e = jsonDecode(response.body);
      int id = e['id'];
      String postNumber = e['postNumber'];
      String status = e['statusAndHandleDateTime'];
      String incidentTime = e['incidentTime'];
      String city = e['city'];
      String distirct = e['district'];
      String category = e['category'];
      String addInfo = e['additionalInfo'];
      String decr = e['description'];
      String imUrl = e['imageUrl'];
      String iinAuthor = e['applicant'];

      print(status.indexOf(RegExp(r'[0-9]')));
      SinglePostModel posts = SinglePostModel(
        iinA: iinAuthor,
        id: id,
        postNumber: postNumber.substring(4),
        status: status.substring(
            // status.substring(0, status.lastIndexOf(' ')).lastIndexOf(' ')),
            0,
            status.indexOf(RegExp(r'[0-9]')) - 1),
        city: city,
        distirct: distirct,
        time: incidentTime.substring(11),
        date: incidentTime.substring(0, 11),
        statusTime: status.substring(status.indexOf(RegExp(r'[0-9]')) - 1),
        add_info: addInfo,
        description: decr,
        category: category,
        urlToImage: imUrl,
      );

      print(posts);
      return posts;
    }
    return null;
  }

  Future<bool> patchStatusPost(int id, String status) async {
    print('PATCH STATUS API');
    String token = tokenBox.get('token');
    print(status);
    final response = await http.patch(
      Uri.parse(baseUrl + 'posts/status'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(
        {"id": id, "statusCode": status},
      ),
    );
    print(response.body);
    print(response.statusCode);

    return response.statusCode == 200;
  }

  Future<bool> addPost(AddPostModel addPostModel) async {
    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(baseUrl + 'posts'));
    String token = tokenBox.get('token');
    print(token);
    imageUploadRequest.headers.addAll({
      'Content-Type': 'application/json',
      // 'Content-Type': 'multipart/form-data',
      // 'Content-Type':
      //     'multipart/form-data; boundary=<calculated when request is sent>',
      "Authorization": "Bearer $token",
      // "accept": "application/json",
    });

    print(imageUploadRequest.headers.toString());

    // imageUploadRequest.fields['postCreateDto'] = jsonEncode(
    //   {
    //     'city': addPostModel.city,
    //     'distirct': addPostModel.distirct,
    //     'incidentTime': addPostModel.time,
    //     'category': addPostModel.category,
    //     'description': addPostModel.description,
    //     'additionalInfo': addPostModel.addInfo,
    //   },
    // );

    // print(CreatePostJsonModel(
    //   city: addPostModel.city,
    //   district: addPostModel.distirct,
    //   incidentTime: addPostModel.time,
    //   category: addPostModel.category,
    //   description: addPostModel.description,
    //   additionalInfo: addPostModel.addInfo,
    //   // ).toJson(),
    // ).toString());
    // var jsonPart = http.MultipartFile.fromString(
    //   'postCreateDto',
    //   // jsonDecode(jsonEncode(
    //   //   {
    //   //     'city': addPostModel.city,
    //   //     'district': addPostModel.distirct,
    //   //     'incidentTime': addPostModel.time,
    //   //     'category': addPostModel.category,
    //   //     'description': addPostModel.description,
    //   //     'additionalInfo': addPostModel.addInfo,
    //   //   },
    //   // ).toString()),
    //   CreatePostJsonModel(
    //     city: addPostModel.city,
    //     district: addPostModel.distirct,
    //     incidentTime: addPostModel.time,
    //     category: addPostModel.category,
    //     description: addPostModel.description,
    //     additionalInfo: addPostModel.addInfo,
    //     // ).toJson(),
    //   ).toMap().toString(),
    //   // ).toString(),
    //   // filename: 'postCreateDto.json',
    // );
    print(addPostModel);

    // final byteCompressed = await FlutterImageCompress.compressWithFile(
    //   addPostModel.imagePath.path,
    //   quality: 80,
    //   // format: CompressFormat.jpeg,
    // );
    // var imageFile = await http.MultipartFile.fromBytes(
    //   'image',
    //   byteCompressed!,
    // );
    // var imageFileF = await http.MultipartFile.fromPath(
    //   'image',
    //   addPostModel.imagePath.path,
    //   // contentType: MediaType('application', 'jpg'),
    // );
    // imageUploadRequest.files.add(jsonPart);
    // imageUploadRequest.files.add(imageFileF);
    imageUploadRequest.files.add(await http.MultipartFile.fromPath(
      'image',
      addPostModel.imagePath.path,
      // contentType: MediaType('application', 'jpg'),
    ));
    String tt = addPostModel.time.replaceFirst('AM', '').replaceFirst('PM', '');
    tt = tt[tt.length - 1] == ' ' ? tt.substring(0, tt.length - 1) : tt;
    imageUploadRequest.fields['city'] = addPostModel.city;
    imageUploadRequest.fields['district'] = addPostModel.distirct;
    imageUploadRequest.fields['incidentTime'] = tt;
    imageUploadRequest.fields['category'] = addPostModel.category;
    imageUploadRequest.fields['description'] = addPostModel.description;
    imageUploadRequest.fields['additionalInfo'] = addPostModel.addInfo;
    print(imageUploadRequest.fields);
    final response = await imageUploadRequest.send();

    print('RESPONSE STATUS CODE IS ${response.statusCode}');
    print('RESPONSE BODY ${response.reasonPhrase.toString()}');
    print('RESPONSE BODY ${response.contentLength}');

    return response.statusCode == 200;
  }
}
