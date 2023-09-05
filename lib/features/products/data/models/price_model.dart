import 'package:pear_market/core/util/enums/price_status_enum.dart';
import 'package:pear_market/core/util/enums/product_currency_enum.dart';
import 'package:pear_market/features/products/domain/entities/price_entity.dart';

class PriceModel extends PriceEntity {
  const PriceModel({
    required super.price,
    super.exRate,
    required super.dateTime,
    required super.status,
    super.currency,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      price: json["price"],
      exRate: json["exRate"],
      dateTime: DateTime.parse(json["dateTime"]),
      status: PriceStatusEnum.values[json["status"]],
      currency: ProductCurrencyEnum.values[json["currency"]],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "exRate": exRate,
      "dateTime": dateTime.toString(),
      "status": status.index,
      "currency": currency.index,
    };
  }

  factory PriceModel.fromEntity(PriceEntity priceEntity) {
    return PriceModel(
      price: priceEntity.price,
      exRate: priceEntity.exRate,
      dateTime: priceEntity.dateTime,
      status: priceEntity.status,
      currency: priceEntity.currency,
    );
  }
}
