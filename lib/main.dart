import 'package:day2/ReadData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'FlutterFireBase Sample',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.indigo,
      //   brightness: Brightness.dark,
      // ),
      home: ReadData(),

      );

  }
}
