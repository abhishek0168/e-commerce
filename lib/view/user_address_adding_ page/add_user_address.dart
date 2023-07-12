import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/admin_panel/product_page/admin_text_form_widget.dart';
import 'package:ecommerce_app/view/widgets/custom_submit_button.dart';
import 'package:ecommerce_app/view_model/user_address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserAddress extends StatelessWidget {
  AddUserAddress({super.key, this.addressId});
  final _formKey = GlobalKey<FormState>();
  final String? addressId;
  @override
  Widget build(BuildContext context) {
    final addressController = Provider.of<AddressViewModel>(context);
    final screenSize = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        addressController.clearTextFeild();
        addressController.isUpdating = false;
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: !addressController.isUpdating
              ? const Text('Add shipping address')
              : const Text('Edit shipping address'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                addressController.clearTextFeild();
                addressController.isUpdating = false;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AdminTextForm(
                    controller: addressController.nameController,
                    title: 'Name',
                  ),
                  AdminTextForm(
                    controller: addressController.phoneNoController,
                    title: 'Phone number',
                  ),
                  AdminTextForm(
                    controller: addressController.houseNameController,
                    title: 'House name',
                  ),
                  AdminTextForm(
                    controller: addressController.cityController,
                    title: 'City',
                  ),
                  AdminTextForm(
                    controller: addressController.districtController,
                    title: 'District',
                  ),
                  AdminTextForm(
                    controller: addressController.stateController,
                    title: 'State',
                  ),
                  AdminTextForm(
                    controller: addressController.pinCodeController,
                    title: 'PIN code',
                  ),
                  AdminTextForm(
                    controller: addressController.countyController,
                    title: 'County',
                  ),
                  height20,
                  CustomSubmitButton(
                    screenSize: screenSize,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        if (addressController.isUpdating && addressId != null) {
                          addressController.updateUserAddress(
                              addressId!, context);
                        } else {
                          addressController.addUserAddress(context);
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    title: addressController.isUpdating
                        ? 'update address'
                        : 'save address',
                  ),
                  height10,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
