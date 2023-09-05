import 'package:equatable/equatable.dart';
import 'package:pear_market/features/products/domain/entities/price_entity.dart';
import 'package:pear_market/features/products/domain/entities/product_configuration_entity.dart';
import 'package:pear_market/features/products/domain/entities/product_info_entity.dart';

class ProductEntity extends Equatable {
  final String? id;
  final ProductConfigurationEntity productConfiguration;
  final ProductInfoEntity productInfo;
  final PriceEntity buyPrice;
  final PriceEntity sellPrice;
  final String description;

  const ProductEntity({
    this.id,
    required this.productConfiguration,
    required this.sellPrice,
    required this.productInfo,
    required this.buyPrice,
    required this.description,
  });

  double get getPriceDiference {
    if (sellPrice != PriceEntity.sellEmpty()) {
      return (sellPrice.price * sellPrice.exRate) -
          (buyPrice.price * buyPrice.exRate);
    }

    return 0;
  }

  int get getDateTimeDiference {
    if (sellPrice != PriceEntity.sellEmpty()) {
      return (sellPrice.dateTime).difference(buyPrice.dateTime).inDays;
    }
    return 0;
  }

  factory ProductEntity.empty() {
    return ProductEntity(
      productInfo: ProductInfoEntity.empty(),
      buyPrice: PriceEntity.buyEmpty(),
      sellPrice: PriceEntity.sellEmpty(),
      productConfiguration: ProductConfigurationEntity.empty(),
      description: "",
    );
  }

  // @override
  // String toString() {
  //   return "$generation ${color ?? ""} ${storage ?? ""}";
  // }

  ProductEntity copyWith({
    String? id,
    ProductConfigurationEntity? productConfiguration,
    ProductInfoEntity? productInfo,
    PriceEntity? buyPrice,
    PriceEntity? sellPrice,
    String? description,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      productConfiguration: productConfiguration ?? this.productConfiguration,
      productInfo: productInfo ?? this.productInfo,
      buyPrice: buyPrice ?? this.buyPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        buyPrice,
        sellPrice,
        description,
        productConfiguration,
        productInfo,
      ];
}
