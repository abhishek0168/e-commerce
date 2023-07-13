import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/view/admin_panel/user_page/user_details.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UsersDisplay extends StatelessWidget {
  const UsersDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetailsController = Provider.of<UserDetailsViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<UserModel>>(
        future: userDetailsController.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final usersList = snapshot.data;
            return ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserDetails(userId: usersList[index].id),
                          ),
                        );
                      },
                      // leading: SizedBox(
                      //   width: 50,
                      //   child: SvgPicture.asset(
                      //       'assets/svgs/user-image-with-black-background-svgrepo-com.svg'),
                      // ),
                      title: Text(usersList[index].userName),
                      subtitle: Text(usersList[index].userEmail),
                      trailing: usersList[index].userStatus
                          ? null
                          : const Text(
                              'Blocked',
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                    ),
                separatorBuilder: (context, index) => Container(),
                itemCount: usersList!.length);
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Somthing went wrong :(\n${snapshot.error}'));
          } else {
            return threeDotLoadingAnimation();
          }
        },
      ),
    );
  }
}
