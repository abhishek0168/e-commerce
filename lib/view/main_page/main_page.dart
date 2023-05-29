import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/home/home_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/main_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final screens = [
    HomePage(),
    const Placeholder(color: Colors.yellow),
    const Placeholder(color: Colors.orange),
    const Placeholder(color: Colors.green),
    const Placeholder(color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    MainPageViewModel mainPageviewModel = context.watch<MainPageViewModel>();
    return SafeArea(
      child: Scaffold(
        body: screens[mainPageviewModel.currentIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            elevation: 0,
            backgroundColor: AppColors.whiteColor,
            indicatorColor: AppColors.whiteColor,
          ),
          child: NavigationBar(
            selectedIndex: mainPageviewModel.currentIndex,
            onDestinationSelected: (int newIndex) {
              mainPageviewModel.changeIndex(newIndex);
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.home,
                  color: AppColors.primaryColor,
                ),
                icon: Icon(Icons.home_outlined),
                label: home,
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.local_grocery_store,
                  color: AppColors.primaryColor,
                ),
                icon: Icon(Icons.local_grocery_store_outlined),
                label: shop,
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.shopping_bag,
                  color: AppColors.primaryColor,
                ),
                icon: Icon(Icons.shopping_bag_outlined),
                label: bag,
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.favorite,
                  color: AppColors.primaryColor,
                ),
                icon: Icon(Icons.favorite_border),
                label: fav,
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                ),
                icon: Icon(Icons.person_outline),
                label: profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
