import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/cart/cart_page.dart';
import 'package:ecommerce_app/view/favorite_page/favorite_page.dart';
import 'package:ecommerce_app/view/home/home_page.dart';
import 'package:ecommerce_app/view/profile_page/profile_page.dart';
import 'package:ecommerce_app/view/shop/shop_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/main_page_view_model.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final screens = [
    HomePage(),
    const ShopPage(),
    const CartPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final mainPageviewModel = context.watch<MainPageViewModel>();
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    // userDetailsController.fetchingUserData();

    return SafeArea(
      child: Scaffold(
        appBar: mainPageviewModel.currentIndex == 0 ? null : AppBar(),
        body: screens[mainPageviewModel.currentIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            elevation: 0,
            // backgroundColor: AppColors.whiteColor,
            indicatorColor: AppColors.whiteColor,
          ),
          child: NavigationBar(
            selectedIndex: mainPageviewModel.currentIndex,
            onDestinationSelected: (int newIndex) {
              mainPageviewModel.changeIndex(newIndex);
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              const NavigationDestination(
                selectedIcon: Icon(
                  Icons.home,
                  color: AppColors.primaryColor,
                ),
                icon: Icon(Icons.home_outlined),
                label: home,
              ),
              const NavigationDestination(
                selectedIcon: Icon(
                  Icons.local_grocery_store,
                  color: AppColors.primaryColor,
                ),
                icon: Icon(Icons.local_grocery_store_outlined),
                label: shop,
              ),
              NavigationDestination(
                selectedIcon: Stack(
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      color: AppColors.primaryColor,
                    ),
                    Visibility(
                      visible: userDetailsController.userCart.isNotEmpty,
                      child: Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: AppColors.starColor,
                          minRadius: 5,
                        ),
                      ),
                    ),
                  ],
                ),
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                    Visibility(
                      visible: userDetailsController.userCart.isNotEmpty,
                      child: const Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          minRadius: 5,
                        ),
                      ),
                    ),
                  ],
                ),
                label: bag,
              ),
              const NavigationDestination(
                selectedIcon: Icon(
                  Icons.favorite,
                  color: AppColors.primaryColor,
                ),
                icon: Icon(Icons.favorite_border),
                label: fav,
              ),
              const NavigationDestination(
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
