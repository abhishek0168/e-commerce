import 'package:ecommerce_app/view/admin_panel/product_page/admin_product_adding_page.dart';
import 'package:ecommerce_app/view/admin_panel/product_page/admin_product_view_page.dart';
import 'package:ecommerce_app/view/admin_panel/promo_code_page/promo_code_list.dart';
import 'package:ecommerce_app/view/admin_panel/user_page/users_display.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/admin_page_viewmodel.dart';
import 'package:ecommerce_app/view_model/product_data_from_firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDisplayPage extends StatelessWidget {
  const AdminDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseDataController = Provider.of<DataFromFirebase>(context);
    final adminPageController = Provider.of<AdminPageViewModel>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: UnconstrainedBox(
                child: Image.asset(
                  'assets/logo/glimp_logo_white.png',
                  fit: BoxFit.contain,
                  width: 150,
                ),
              ),
            ),
            ListTile(
              title: const Text('User Details'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsersDisplay(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('promo code'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PromoCodeList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxisScrolled) => [
          const SliverAppBar(
            floating: true,
            snap: true,
            title: Text('Products'),
          )
        ],
        body: RefreshIndicator(
          onRefresh: () => firebaseDataController.callPrductDetails(),
          child: Consumer<DataFromFirebase>(
            builder: (context, value, child) {
              return value.productsData.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminProductViewPage(
                                productData: value.productsData[index],
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(value.productsData[index].brandName),
                            subtitle: Text(
                                'Stock : ${value.productsData[index].productStock}'),
                            leading: Container(
                              width: 100,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      value
                                          .productsData[index].productImages[0],
                                    ),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: value.productsData.length)
                  : threeDotLoadingAnimation();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          adminPageController.isUpdate = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminProductAddingPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
