import 'dart:developer';

import 'package:ecommerce_app/model/user_model/user_model.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressShowWidget extends StatelessWidget {
  const AddressShowWidget({
    super.key,
    required this.data,
    this.navigateTo,
    this.isUpdate = false,
  });
  final UserAddress data;
  final Widget? navigateTo;
  final bool isUpdate;
  @override
  Widget build(BuildContext context) {
    final addressModel = Provider.of<AddressViewModel>(context);
    return Card(
      surfaceTintColor: AppColors.blackColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data.name),
                TextButton(
                  onPressed: () {
                    if (isUpdate) {
                      addressModel.editAddress(data);
                      addressModel.isUpdating = true;
                    }
                    if (navigateTo != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => navigateTo!,
                        ),
                      );
                    }
                  },
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                  child: isUpdate ? const Text('Edit') : const Text('Change'),
                ),
              ],
            ),
            Text(data.mobileNumber),
            Text(data.houseName),
            Text('${data.city}, ${data.district}'),
            Text(data.pincode),
            if (isUpdate)
              CheckboxListTile(
                tristate: true,
                value: addressModel.selectedAddress?.id == data.id,
                onChanged: (value) {
                  log(value.toString());
                  addressModel.updateSelectedAddress(data, value!);
                },
                title: const Text('Use as the shipping address'),
                controlAffinity: ListTileControlAffinity.leading,
              )
          ],
        ),
      ),
    );
  }
}
