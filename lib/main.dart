import 'package:ecommerce_app/view/main_page/main_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/main_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MainPageViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter e-commerce',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: MainPage(),
      ),
    );
  }
}
