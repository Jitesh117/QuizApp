import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Styles/text_styles.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({
    super.key,
    required this.imagePath,
    required this.price,
    required this.bgColor,
    required this.numberOfItems,
  });
  final String imagePath;
  final int price;
  final Color bgColor;
  final int numberOfItems;
  @override
  Widget build(BuildContext context) {
    double cardHeight = (MediaQuery.of(context).size.width - 60) / 2;

    return Container(
      width: cardHeight,
      height: cardHeight,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black, width: 4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                // number of current item player has
                Image.asset(
                  imagePath,
                  height: cardHeight - 75,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        textScaleFactor: ScaleSize.textScaleFactor(context),
                        numberOfItems.toString(),
                        style: regularBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textScaleFactor: ScaleSize.textScaleFactor(context),
                  '$price',
                  style: midBold,
                ),
                const SizedBox(width: 5),
                const FaIcon(FontAwesomeIcons.coins),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
