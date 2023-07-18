import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/order_summary/display_order_list.dart';
import 'package:ecommerce_app/view/profile_page/profile_listtile_widget.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/user_address_adding_%20page/select_user_address.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:ecommerce_app/view_model/main_page_view_model.dart';
import 'package:ecommerce_app/view_model/sign_in_page_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    // final userAddressModel = Provider.of<AddressViewModel>(context);
    final signInpageViewModel = Provider.of<SignInPageViewModel>(context);
    final mainPageviewModel = context.watch<MainPageViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          Text(
            'My profile',
            style: CustomeTextStyle.mainHeadingBlack
                .copyWith(color: AppColors.primaryColor),
          ),
          height20,
          ListTile(
            // leading: SvgPicture.asset(
            //   'assets/svgs/user-image-with-black-background-svgrepo-com.svg',
            //   width: 60,
            // ),
            title: H2(text: userDetailsController.userData!.userName),
            subtitle: Text(userDetailsController.userData!.userEmail),
          ),
          // const Divider(),
          Consumer<UserDetailsViewModel>(
            builder: (context, value, child) => ProfileListTile(
              title: 'My order',
              subtitle: value.totalOrderList.length <= 1
                  ? '${value.totalOrderList.length} order'
                  : '${value.totalOrderList.length} orders',
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DisplayOrderList(
                      orderList: userDetailsController.totalOrderList.reversed
                          .toList()),
                ));
              },
            ),
          ),
          Consumer<AddressViewModel>(
            builder: (context, value, child) => ProfileListTile(
              title: 'Shipping addresses',
              subtitle: value.userAddresss.length <= 1
                  ? '${value.userAddresss.length} address'
                  : '${value.userAddresss.length} addresses',
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SelectUserAddress(),
                ));
              },
            ),
          ),
          // ProfileListTile(
          //   title: 'Payment methods',
          //   subtitle: '',
          //   onPress: () {},
          // ),
          // ProfileListTile(
          //   title: 'Settings',
          //   subtitle: '',
          //   onPress: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const UserEditPage(),
          //       ),
          //     );
          //   },
          // ),
          TextButton.icon(
            onPressed: () {
              signInpageViewModel.signOutUser();
              mainPageviewModel.changeIndex(0);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(AppColors.grayColor),
            ),
          ),
        ],
      ),
    );
  }
}