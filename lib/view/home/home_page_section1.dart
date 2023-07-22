import 'dart:developer';

import 'package:ecommerce_app/view/home/home_page_widgets.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:ecommerce_app/view_model/main_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageSection1 extends StatelessWidget {
  const HomePageSection1({
    super.key,
    required this.imageDr,
  });

  final List<String> imageDr;

  @override
  Widget build(BuildContext context) {
    final mainPageController = Provider.of<MainPageViewModel>(context);
    final firebaseDataController = Provider.of<DataFromFirebase>(context);
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          onTap: () async {
            // await firebaseDataController.callPrductDetails();
            firebaseDataController.selectedPage = ChooseShopPage.all;
            mainPageController.changeIndex(1);
          },
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height / 2,
            child: ImageDispaly(
              imgaeDr: imageDr[0],
              text: 'New collection',
              position: TextPosition.bottom,
              
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        SizedBox(
          width: screenSize.width,
          height: screenSize.height / 2.5,
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  log("Home page Women section tabed");
                  firebaseDataController.selectedPage = ChooseShopPage.women;
                  mainPageController.changeIndex(1);
                },
                child: SizedBox(
                  width: screenSize.width / 2,
                  child: ImageDispaly(
                    imgaeDr: imageDr[1],
                    text: 'Women\'s',
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  log("Home page Women section tabed");
                  firebaseDataController.selectedPage = ChooseShopPage.men;

                  mainPageController.changeIndex(1);
                },
                child: SizedBox(
                    width: screenSize.width / 2,
                    child: ImageDispaly(
                      imgaeDr: imageDr[2],
                      text: 'Men\'s',
                      alignment: Alignment.topCenter,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
