import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Text(
            'Settings',
            style: CustomeTextStyle.mainHeadingBlack.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          height20,
          Text(
            'Personal Information',
            style: CustomeTextStyle.boldName,
          ),
          height10,
          // UnconstrainedBox(
          //   child: Stack(
          //     children: [
          //       CircleAvatar(
          //         radius: 60,
          //         backgroundColor: AppColors.grayColor,
          //       ),
          //       Positioned(
          //         bottom: 0,
          //         right: 0,
          //         child: IconButton.filled(
          //             onPressed: () {},
          //             icon: const Icon(Icons.camera_alt_outlined)),
          //       )
          //     ],
          //   ),
          // ),

          Row(
            children: [
              SizedBox(
                width: (80 / 100) * screenSize.width,
                child: TextFormField(
                  initialValue: userDetailsController.userData!.userName,
                  // enabled: false,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Spacer(),
              IconButton.filled(onPressed: () {}, icon: const Icon(Icons.edit))
            ],
          ),
          height10,
          Row(
            children: [
              SizedBox(
                width: (80 / 100) * screenSize.width,
                child: TextFormField(
                  initialValue: userDetailsController.userData!.userEmail,
                  // enabled: false,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Spacer(),
              IconButton.filled(onPressed: () {}, icon: const Icon(Icons.edit))
            ],
          ),
        ],
      ),
    );
  }
}
