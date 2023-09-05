import 'package:equatable/equatable.dart';
import 'package:pear_market/core/util/enums/price_status_enum.dart';
import 'package:pear_market/core/util/enums/product_currency_enum.dart';

class PriceEntity extends Equatable {
  const PriceEntity({
    required this.price,
    this.exRate = 1,
    required this.dateTime,
    required this.status,
    this.currency = ProductCurrencyEnum.UAH,
  });

  final double price;
  final double exRate;
  final DateTime dateTime;
  final PriceStatusEnum status;
  final ProductCurrencyEnum currency;

  factory PriceEntity.sellEmpty() {
    return PriceEntity(
      price: 0,
      dateTime: DateTime.now(),
      status: PriceStatusEnum.sell,
    );
  }
  factory PriceEntity.buyEmpty() {
    return PriceEntity(
      price: 0,
      dateTime: DateTime.now(),
      status: PriceStatusEnum.buy,
    );
  }

  @override
  List<Object?> get props => [price, exRate, dateTime, status, currency];

  PriceEntity copyWith({
    double? price,
    double? exRate,
    DateTime? dateTime,
    PriceStatusEnum? status,
    ProductCurrencyEnum? currency,
  }) {
    return PriceEntity(
      price: price ?? this.price,
      exRate: exRate ?? this.exRate,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      currency: currency ?? this.currency,
    );
  }
}
