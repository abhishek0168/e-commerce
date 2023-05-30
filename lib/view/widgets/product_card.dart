import 'package:ecommerce_app/view/theme/app_color_theme.dart';
import 'package:ecommerce_app/view/widgets/heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';

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
                Container(
                  width: 180,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/set-1 (3).jpg'),
                        fit: BoxFit.cover),
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
          Container(
            padding: const EdgeInsets.all(5.0),
            width: 180,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: const Text(
                    '10%',
                    style: TextStyle(color: AppColors.whiteColor),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.clear,
                      size: 30,
                    ))
              ],
            ),
          ),
          Positioned(
            top: 200,
            right: 210,
            child: DropShadow(
              color: AppColors.blackColor,
              blurRadius: 1,
              offset: const Offset(0, 3),
              spread: 1,
              opacity: 0.5,
              child: CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
