import 'dart:developer';

import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/user_address_adding_%20page/add_user_address.dart';
import 'package:ecommerce_app/view/widgets/address_widget.dart';
import 'package:ecommerce_app/view/widgets/three_dot_loading.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectUserAddress extends StatelessWidget {
  const SelectUserAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final userAddressModel = Provider.of<AddressViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select address'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: userAddressModel.getUserAddress(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              final addressList = snapshot.data;
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) => AddressShowWidget(
                    isUpdate: true,
                    data: addressList[index],
                    navigateTo: AddUserAddress(
                      addressId: addressList[index].id,
                    )),
                separatorBuilder: (context, index) => height10,
                itemCount: addressList!.length,
              );
            } else {
              return const Center(
                child: Text('empty'),
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong :('),
            );
          } else {
            return threeDotLoadingAnimation();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserAddress(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
