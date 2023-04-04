import 'package:firebase/provider/home_provider.dart';
import 'package:firebase/repository/user_repository.dart';
import 'package:firebase/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  UserRepository().registerAdapter();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => Homeprovider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
     home: HomePage());
  }
}
