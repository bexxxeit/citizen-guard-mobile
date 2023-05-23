import 'package:diploma_citizen/screens/auth/login_page.dart';
import 'package:diploma_citizen/screens/home/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:diploma_citizen/screens/home/home_page.dart';
import 'package:diploma_citizen/screens/single_post/get_single_post_bloc/get_single_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/add_post/add_post_bloc/add_post_bloc.dart';
import 'screens/auth/auth_bloc/auth_bloc.dart';
import 'screens/auth/other_pages/get_cities_bloc/get_cities_bloc.dart';
import 'screens/components/get_categories_bloc/get_categories_bloc.dart';
import 'screens/home/bloc/get_userprofile_bloc/get_userprofile_bloc.dart';
import 'screens/home/bloc/user_me_bloc/user_me_bloc.dart';
import 'screens/search/get_search_posts_bloc/get_search_posts_bloc.dart';
import 'screens/single_post/patch_status_bloc/patch_status_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hive.registerAdapter(UserModelAdapter()); // id = 0
  await Hive.initFlutter();
  // await Hive.openBox<UserModel>('user');
  await Hive.openBox('tokens');
  await Hive.openBox('userType');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var tokenBox = Hive.box('tokens');
    print(tokenBox.get('token'));
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<GetCitiesBloc>(create: (context) => GetCitiesBloc()),
        BlocProvider<GetSearchPostsBloc>(
            create: (context) => GetSearchPostsBloc()),
        BlocProvider<GetSinglePostBloc>(
            create: (context) => GetSinglePostBloc()),
        BlocProvider<GetCategoriesBloc>(
            create: (context) => GetCategoriesBloc()),
        BlocProvider<UserMeBloc>(create: (context) => UserMeBloc()),
        BlocProvider<AddPostBloc>(create: (context) => AddPostBloc()),
        BlocProvider<PatchStatusBloc>(create: (context) => PatchStatusBloc()),
        BlocProvider<GetUserPostsBloc>(create: (context) => GetUserPostsBloc()),
        BlocProvider<GetUserprofileBloc>(
            create: (context) => GetUserprofileBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: tokenBox.get('token') != null ? HomePage() : LoginPage(),
        // home: LoginPage(),
      ),
    );
  }
}
