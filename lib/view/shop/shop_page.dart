import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/product_card.dart';
import 'package:ecommerce_app/view_model/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  ShopPage({super.key});
  final List<String> filterChips = [
    'T-shirts',
    'Crop tops',
    'Midi Dress',
    'Salwar Kameez',
    'Lehenga Choli',
  ];

  @override
  Widget build(BuildContext context) {
    ShopViewModel shopViewModel = context.watch<ShopViewModel>();
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filterChips
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      showCheckmark: false,
                      label: Text(e),
                      labelStyle: TextStyle(
                          color: shopViewModel.filter.contains(e)
                              ? AppColors.whiteColor
                              : AppColors.blackColor),
                      selected: shopViewModel.filter.contains(e),
                      selectedColor: AppColors.blackColor,
                      onSelected: (value) {
                        shopViewModel.changeSelection(value, e);
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0.1,
                blurRadius: 7,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                label: const Text('Filter'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.swap_vert),
                label: const Text('Sort'),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return const ProductCard();
                }),
          ),
        ),
      ],
    );
  }
}