import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/book_list_screen.dart'; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Week1App());
}

class Week1App extends StatelessWidget {
  const Week1App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Bible Reader Week 1',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
            colorScheme: const ColorScheme.dark(
              primary: Colors.redAccent,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const BookListScreen(),
        );
      },
    );
  }
}
