// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pear_market/core/service/service_navigation.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/statistic_entity.dart';

import 'package:pear_market/features/products/domain/usecase/product_usecases/get_statistic_usecase.dart';
import 'package:pear_market/features/products/presentation/widgets/show_snackbar_info.dart';

class MenuViewModelState {
  final double width = 20;
  final Color leftBarColor = Colors.purple;
  final Color rightBarColor = Colors.green;

  final List<BarChartGroupData> items;
  final double _maxMoney;
  double _totalMoney;

  double get maxMoney => _maxMoney * 2;
  double get totalMoney => _totalMoney;
  set totalMoney(value) => _totalMoney += value;

  MenuViewModelState({
    this.items = const [],
    double maxMoney = 0,
    double totalMoney = 0,
  })  : _maxMoney = maxMoney,
        _totalMoney = totalMoney;

  MenuViewModelState copyWith({
    List<BarChartGroupData>? items,
    double? maxMoney,
    double? totalMoney,
  }) {
    return MenuViewModelState(
      items: items ?? this.items,
      maxMoney: maxMoney ?? _maxMoney,
      totalMoney: totalMoney ?? this.totalMoney,
    );
  }
}

class MenuViewModel extends ChangeNotifier {
  final GetStatisticUseCase getStatisticUseCase;
  final BuildContext context;
  MenuViewModelState state = MenuViewModelState();
  MenuViewModel(this.getStatisticUseCase, this.context) {
    init();
  }

  void onMenuItemTap(int index) async {
    await Navigator.of(context).pushNamed(
      AppNavigationNames.productList,
      arguments: ProductType.values[index],
    );
    state = MenuViewModelState();
    init();
  }

  Future<void> init() async {
    final result = await getStatisticUseCase();

    result.fold(
      (l) => showSnackbarInfo(context, "Failed load statistic"),
      (r) {
        for (StatisticEntity e in r) {
          if (e.buySum > e.sellSum) {
            state = state.copyWith(
                maxMoney:
                    e.buySum > state._maxMoney ? e.buySum : state._maxMoney);
          } else {
            state = state.copyWith(
                maxMoney:
                    e.sellSum > state._maxMoney ? e.sellSum : state._maxMoney);
          }

          state.totalMoney = e.sellSum - e.buySum;
        }

        state = state.copyWith(
            items:
                r.map((e) => makeGroupData(1, e.buySum, e.sellSum)).toList());
      },
    );
    notifyListeners();
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1 > y2 ? y1 : y2,
          color: Colors.transparent,
          width: state.width,
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          rodStackItems: [
            BarChartRodStackItem(
              0,
              y1 > y2 ? y1 : y2,
              y1 > y2 ? state.leftBarColor : state.rightBarColor,
              const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            BarChartRodStackItem(
              0,
              y1 > y2 ? y2 : y1,
              y1 > y2 ? state.rightBarColor : state.leftBarColor,
              const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
