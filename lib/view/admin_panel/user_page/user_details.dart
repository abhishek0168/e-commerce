import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.userData});
  final UserModel userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          SvgPicture.asset(
            'assets/svgs/user-image-with-black-background-svgrepo-com.svg',
            width: 190,
          ),
          DataTable(
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Details')),
            ],
            rows: [
              DataRow(
                cells: [
                  const DataCell(Text('Name')),
                  DataCell(Text(userData.userName)),
                ],
              ),
              DataRow(
                cells: [
                  const DataCell(Text('Email')),
                  DataCell(Text(userData.userEmail)),
                ],
              ),
              DataRow(
                cells: [
                  const DataCell(Text('Address')),
                  DataCell(Container(
                    width: 30,
                    height: 30,
                    color: AppColors.starColor,
                  )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
