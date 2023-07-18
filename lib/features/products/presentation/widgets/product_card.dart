import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/colors.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final Function() onTapCard;
  final Function() onTapSell;
  final ProductEntity product;

  ProductCard({
    super.key,
    required this.onTapCard,
    required this.onTapSell,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCard,
      child: Container(
        padding: EdgeInsets.all(AppDemensions.appSize10),
        color: AppColors.productCardColor,
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(AppDemensions.appSize5),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Text(
                        product.condition.name,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: AppDemensions.appSize20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: AppDemensions.appSize150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/${product.type.name}.png'),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              product.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: AppDemensions.appSize20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            product.status == ProductStatus.instock
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onTapSell,
                      child: Text(
                        'SELL',
                        style: GoogleFonts.montserrat(
                          fontSize: AppDemensions.appSize20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "DAYS: ${product.getDateTimeDiference}",
                        style: GoogleFonts.montserrat(
                          fontSize: AppDemensions.appSize20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        product.getPriceDiference.toString(),
                        style: GoogleFonts.montserrat(
                          fontSize: AppDemensions.appSize20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
