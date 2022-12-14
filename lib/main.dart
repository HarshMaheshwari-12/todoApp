import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/login_screen.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/constant.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My todo list',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // brightness: Brightness.light,
          primaryColor: Constant.defaultTheme().primaryColor,
          // backgroundColor: Colors.deepPurpleAccent,
          colorScheme:
              ColorScheme.fromSwatch(backgroundColor: Colors.deepPurpleAccent)
                  .copyWith(secondary: Colors.deepPurpleAccent)),
      home: LoginScreen(),
    );
  }
}
