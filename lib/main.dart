import 'package:flutter/material.dart';
// import 'package:my_delivery/common/component/custom_text_form_field.dart';
import 'package:my_delivery/common/view/splash_screen.dart';
// import 'package:my_delivery/user/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      // home: LoginScreen(),
      home: SplashScreen(),
    );
  }
}
