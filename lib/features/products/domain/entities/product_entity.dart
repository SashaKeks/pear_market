// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';

import '../../../../core/util/enums.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? color;
  final String? storage;
  final String? ram;
  final String? proc;
  final String? video;
  final double buyPrice;
  final ProductCurrency buyCurrency;
  final double buyExRate;
  final DateTime buyDateTime;
  final double? sellPrice;
  final ProductCurrency sellCurrency;
  final double? sellExRate;
  final DateTime? sellDateTime;
  final ProductType type;
  final String generation;
  final String description;
  final ProductStatus status;
  final ProductCondition condition;
  final String ownerid;

  ProductEntity({
    this.id,
    this.sellPrice,
    this.sellCurrency = ProductCurrency.UAH,
    this.sellExRate,
    this.sellDateTime,
    this.buyExRate = 1,
    required this.type,
    required this.color,
    required this.ram,
    required this.video,
    required this.proc,
    required this.status,
    required this.buyPrice,
    required this.buyDateTime,
    this.buyCurrency = ProductCurrency.UAH,
    required this.storage,
    required this.condition,
    required this.generation,
    required this.description,
    required this.ownerid,
  });

  double get getPriceDiference {
    if (sellPrice == null) return 0;
    return (sellPrice! * (sellExRate ?? 1)) - (buyPrice * buyExRate);
  }

  int get getDateTimeDiference {
    return (sellDateTime ?? DateTime.now()).difference(buyDateTime).inDays;
  }

  factory ProductEntity.empty() {
    return ProductEntity(
        type: ProductType.iphone,
        color: null,
        status: ProductStatus.instock,
        buyPrice: 0,
        buyDateTime: DateTime.now(),
        storage: null,
        condition: ProductCondition.NEW,
        proc: null,
        ram: null,
        video: null,
        generation: "",
        description: "",
        ownerid: "");
  }

  @override
  String toString() {
    return "$generation ${color ?? ""} ${storage ?? ""}";
  }

  ProductEntity copyWith(
      {String? id,
      String? color,
      String? storage,
      String? ram,
      String? proc,
      String? video,
      double? buyPrice,
      ProductCurrency? buyCurrency,
      double? buyExRate,
      DateTime? buyDateTime,
      double? sellPrice,
      ProductCurrency? sellCurrency,
      double? sellExRate,
      DateTime? sellDateTime,
      ProductType? type,
      String? generation,
      String? description,
      ProductStatus? status,
      ProductCondition? condition,
      String? ownerid}) {
    return ProductEntity(
      id: id ?? this.id,
      color: color ?? this.color,
      storage: storage ?? this.storage,
      ram: ram ?? this.ram,
      proc: proc ?? this.proc,
      video: video ?? this.video,
      buyPrice: buyPrice ?? this.buyPrice,
      buyCurrency: buyCurrency ?? this.buyCurrency,
      buyExRate: buyExRate ?? this.buyExRate,
      buyDateTime: buyDateTime ?? this.buyDateTime,
      sellPrice: sellPrice ?? this.sellPrice,
      sellCurrency: sellCurrency ?? this.sellCurrency,
      sellExRate: sellExRate ?? this.sellExRate,
      sellDateTime: sellDateTime ?? this.sellDateTime,
      type: type ?? this.type,
      generation: generation ?? this.generation,
      description: description ?? this.description,
      status: status ?? this.status,
      condition: condition ?? this.condition,
      ownerid: ownerid ?? this.ownerid,
    );
  }

  @override
  List<Object?> get props => [
        id,
        color,
        storage,
        ram,
        proc,
        video,
        buyPrice,
        buyCurrency,
        buyExRate,
        buyDateTime,
        sellPrice,
        sellCurrency,
        sellExRate,
        sellDateTime,
        type,
        generation,
        description,
        status,
        condition,
        ownerid,
      ];
}
