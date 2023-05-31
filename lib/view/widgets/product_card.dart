import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    child: Image.asset(
                      'assets/images/set-1 (3).jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: AppColors.starColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Text(
                  'brand name',
                  style: TextStyle(color: AppColors.grayColor),
                ),
                const H2(text: 'product name'),
                const Row(
                  children: [
                    H2(text: '₹ 190'),
                    H2(text: ''),
                  ],
                )
              ],
            ),
          ),
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 05, horizontal: 10),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: const Text(
                    '10%',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.clear,
                    size: 25,
                  ))
            ],
          ),
          Positioned(
            top: 120,
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            ),
          )
        ],
      ),
    );
  }
}
