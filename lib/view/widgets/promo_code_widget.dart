import 'dart:math' as math;

import 'package:ecommerce_app/view/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class PromoCodeWidget extends StatelessWidget {
  const PromoCodeWidget({
    super.key,
    required this.screenSize,
    required this.promoCode,
    required this.expiryDate,
    required this.discount,
  });

  final Size screenSize;
  final String promoCode;
  final String expiryDate;
  final int discount;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: (90 / 100) * screenSize.width,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // H2(text: promoCode),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      promoCode,
                      style: CustomeTextStyle.mainHeadingBlack,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('Valid until $expiryDate'),
                ],
              ),
            ),
            Container(
              width: (35 / 100) * screenSize.width,
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors
                    .primaries[math.Random().nextInt(Colors.primaries.length)],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Transform.rotate(
                angle: -math.pi / 2,
                child: Text(
                  '$discount%\noff',
                  style: CustomeTextStyle.mainHeadingWhite.copyWith(
                    shadows: <Shadow>[
                      const Shadow(
                        offset: Offset(1.0, 5.0),
                        blurRadius: 10,
                        color: Color.fromARGB(200, 0, 0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
