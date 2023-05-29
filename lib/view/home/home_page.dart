import 'package:ecommerce_app/view/widgets/home_page_widgets.dart';
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
    // final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: ImageDispaly(
            imgaeDr: imageDr[0],
            text: 'New collection',
            position: TextPosition.bottom,
            alignment: Alignment.topCenter,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: ImageDispaly(
                imgaeDr: imageDr[1],
                text: 'Women\'s',
                alignment: Alignment.topCenter,
              )),
              Expanded(
                  child: ImageDispaly(
                imgaeDr: imageDr[2],
                text: 'Men\'s',
                alignment: Alignment.topCenter,
              )),
            ],
          ),
        ),
      ],
    );
  }
}
