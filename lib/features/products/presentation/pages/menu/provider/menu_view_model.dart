import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pear_market/core/service/service_navigation.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_out_usecase.dart';
import 'package:pear_market/features/products/domain/entities/statistic_entity.dart';

class MenuViewModelState {
  final double width = 20;
  final Color leftBarColor = Colors.purple;
  final Color rightBarColor = Colors.green;

  final List<BarChartGroupData> items;
  final double _maxMoney;
  double _totalMoney;

  double get maxMoney => _maxMoney * 1.5;
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
  final SignOutUseCase signOutUseCase;
  final BuildContext context;
  List<StatisticEntity> itemsFromData = [];
  MenuViewModelState state = MenuViewModelState();
  MenuViewModel(this.context, {required this.signOutUseCase}) {}

  void onMenuItemTap(int index) async {
    await Navigator.of(context).pushNamed(
      AppNavigationNames.productList,
      arguments: ProductType.values[index],
    );
    state = MenuViewModelState();
  }

  onSignOutButonPress() {
    signOutUseCase();
    Navigator.pushNamedAndRemoveUntil(
        context, AppNavigationNames.authPage, (route) => false);
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

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text =
        "${itemsFromData[value.toInt()].date.month}_${itemsFromData[value.toInt()].date.year}";

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }
}
