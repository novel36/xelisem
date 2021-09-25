import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:message_app/screens/backgound.dart';
// import 'package:message_app/screens/messageHome.dart';
// import 'package:message_app/screens/myMessage.dart';
import 'package:xelisem/screens/myMessage.dart';

// import 'package:message_app/screens/kidsHome.dart';
// import 'package:message_app/screens/messageHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360.0, 672.0),
      builder: () => MaterialApp(
        color: Colors.blue,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomePageWidget(),
      ),
    );
  }
}
