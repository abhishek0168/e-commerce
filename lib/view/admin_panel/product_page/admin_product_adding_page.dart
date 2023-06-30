import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/view/admin_panel/product_page/admin_product_diplaying_page.dart';
import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view_model/admin_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_text_form_widget.dart';

class AdminProductAddingPage extends StatelessWidget {
  AdminProductAddingPage({super.key, this.productId});
  final formGlobalKey = GlobalKey<FormState>();
  final String? productId;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AdminPageViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              controller.clearValues();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: controller.isUpdate
            ? const Text("Update product")
            : const Text('Add product'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formGlobalKey,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.chooseImage();
                    },
                    icon: const Icon(Icons.add_circle_outline_rounded),
                  ),
                  Consumer<AdminPageViewModel>(
                    builder: (context, value, child) {
                      return Wrap(
                        children: value.images
                            .map(
                              (image) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onLongPress: () {
                                    value.removeImage(image);
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                  AdminTextForm(
                    controller: controller.productName,
                    title: 'Product Name',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.productPrice,
                      onChanged: (value) {
                        controller.findDiscountPrice();
                      },
                      decoration: const InputDecoration(
                        label: Text('Product price'),

                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor)),
                        focusedErrorBorder: OutlineInputBorder(),
                        // border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This feild is empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  AdminTextForm(
                    controller: controller.brandName,
                    title: 'Brand name',
                  ),
                  Consumer<AdminPageViewModel>(
                    builder: (context, controller, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                label: Text('Select gender'),
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder()),
                            value: controller.genderDropDownValue,
                            items: controller.genderItemValues
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.onGenderChange(value!);
                            }),
                      );
                    },
                  ),
                  Consumer<AdminPageViewModel>(
                    builder: (context, controller, child) {
                      return Row(
                        children: [
                          Flexible(
                            child: RadioListTile<ProductStatus>(
                              value: ProductStatus.available,
                              groupValue: controller.productStatus,
                              onChanged: (value) {
                                controller.changeStatus(value);
                              },
                              title: const Text('available'),
                            ),
                          ),
                          Flexible(
                            child: RadioListTile<ProductStatus>(
                              value: ProductStatus.unavailable,
                              groupValue: controller.productStatus,
                              onChanged: (value) {
                                controller.changeStatus(value);
                              },
                              title: const Text('unavailable'),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Consumer<AdminPageViewModel>(
                    builder: (context, controller, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                label: Text('Select category'),
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder()),
                            value: controller.categoryDropValue,
                            items: controller.categories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.onCategoryChange(value!);
                            }),
                      );
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Select size',
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
                      Flexible(flex: 2, child: Divider())
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: controller.productSizeS,
                            onChanged: (value) {
                              controller.totalStock();
                            },
                            decoration: const InputDecoration(
                              label: Text('Small'),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This feild is empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: controller.productSizeM,
                            onChanged: (value) {
                              controller.totalStock();
                            },
                            decoration: const InputDecoration(
                              label: Text('Medium'),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This feild is empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: controller.productSizeL,
                            onChanged: (value) {
                              controller.totalStock();
                            },
                            decoration: const InputDecoration(
                              label: Text('Large'),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This feild is empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: controller.productSizeXL,
                            onChanged: (value) {
                              controller.totalStock();
                            },
                            decoration: const InputDecoration(
                              label: Text('Extra large'),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This feild is empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  AdminTextForm(
                    controller: controller.productColor,
                    title: 'Product color',
                  ),
                  AdminTextForm(
                    controller: controller.productStock,
                    title: 'Product stock',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.productDiscount,
                      onChanged: (value) {
                        controller.findDiscountPrice();
                      },
                      decoration: const InputDecoration(
                        label: Text('Product Discount (in percentage)'),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This feild is empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  AdminTextForm(
                    controller: controller.productDiscountedprice,
                    title: 'discounted price',
                  ),
                  height20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (controller.images.isEmpty) {
                              controller.imageErrorSnackbar(context);
                            }
                            if (formGlobalKey.currentState!.validate() &&
                                controller.images.isNotEmpty) {
                              formGlobalKey.currentState!.save();
                              if (controller.isUpdate) {
                                await controller.updateValues(productId!);
                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminDisplayPage(),
                                    ),
                                  );
                                }
                              } else {
                                await controller.uploadValues();
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.sumbitColor),
                          ),
                          child: const Text(
                            'Sumbit',
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                      width20,
                      Flexible(
                        child: OutlinedButton(
                          onPressed: () {
                            controller.showAlertBox(context);
                          },
                          child: const Text('clear'),
                        ),
                      ),
                    ],
                  ),
                  height20,
                ],
              ),
            ),
          ),
          Consumer<AdminPageViewModel>(
            builder: (context, val, child) => Visibility(
              visible: val.isLoading,
              maintainState: false,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.whiteColor.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
