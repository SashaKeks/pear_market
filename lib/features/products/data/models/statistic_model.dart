import 'package:pear_market/features/products/domain/entities/statistic_entity.dart';

class StatisticModel extends StatisticEntity {
  StatisticModel({super.buySum, super.sellSum, required super.date});

  Map<String, dynamic> toJson() {
    return {
      "buy": buySum,
      "sell": sellSum,
      "date": date,
    };
  }

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      buySum: double.parse(json["buy"].toString()),
      sellSum: double.parse(json["sell"].toString()),
      date: json["date"].toDate(),
    );
  }
}
