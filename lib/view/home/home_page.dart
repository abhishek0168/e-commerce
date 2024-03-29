import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/home/home_page_section1.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<String> imageDr = [
    'assets/images/main_page_new_arrival.jpg',
    'assets/images/main_page_female_model.jpg',
    'assets/images/main_page_male_model.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HomePageSection1(imageDr: imageDr),
        height20,
      ],
    );
  }
}
