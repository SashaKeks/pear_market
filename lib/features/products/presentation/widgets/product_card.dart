import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/presentation/pages/products/provider/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Function() onTapCard;
  final Function() onTapSell;
  final ProductEntity product;

  const ProductCard({
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
        color: Theme.of(context).primaryColorLight,
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(AppDemensions.appSize5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark)),
                    child: Center(
                      child: Text(
                        product.condition.name,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: AppDemensions.appSize20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark,
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
            context
                    .watch<ProductViewModel>()
                    .userAccessService
                    .canSeeProductOwner
                ? Column(
                    children: [
                      FutureBuilder(
                          future: context
                              .read<ProductViewModel>()
                              .getProductOwner(product.ownerid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Owner:",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        fontSize: AppDemensions.appSize20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data?.name} ${snapshot.data?.surname}",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        fontSize: AppDemensions.appSize20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Text(
                                "Unknowing",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: AppDemensions.appSize20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }
                          }),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  )
                : const SizedBox(),
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
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
