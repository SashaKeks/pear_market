import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/products/presentation/pages/menu/provider/menu_view_model.dart';
import 'package:provider/provider.dart';

class BarChartMoney extends StatelessWidget {
  const BarChartMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Padding(
        padding: EdgeInsets.all(AppDemensions.appSize10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("TOTAL MONEY: "),
                Text(
                  "${context.watch<MenuViewModel>().state.totalMoney} UAH",
                  style: TextStyle(
                    color: context.read<MenuViewModel>().state.totalMoney > 0
                        ? Colors.green
                        : Colors.red,
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppDemensions.appSize25,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: context.read<MenuViewModel>().state.maxMoney,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.white,
                        maxContentWidth: double.infinity,
                        getTooltipItem: (a, b, c, d) {
                          final sell = c.rodStackItems.last.color ==
                                  context
                                      .read<MenuViewModel>()
                                      .state
                                      .rightBarColor
                              ? c.rodStackItems.last.toY
                              : c.rodStackItems.first.toY;
                          final buy = c.rodStackItems.last.color ==
                                  context
                                      .read<MenuViewModel>()
                                      .state
                                      .leftBarColor
                              ? c.rodStackItems.last.toY
                              : c.rodStackItems.first.toY;
                          final earn = sell - buy;
                          return BarTooltipItem(
                            "Earn: ",
                            TextStyle(fontSize: AppDemensions.appSize20),
                            textAlign: TextAlign.start,
                            children: [
                              TextSpan(
                                  text: "$earn\n",
                                  style: TextStyle(
                                      color: earn > 0
                                          ? Colors.green
                                          : Colors.red)),
                              TextSpan(
                                  text: "Buy: $buy\n",
                                  style: const TextStyle(color: Colors.purple)),
                              const TextSpan(
                                  text: "Sell: ",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "$sell",
                                  style: const TextStyle(color: Colors.green))
                            ],
                          );
                        }),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 60),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 20,
                        getTitlesWidget:
                            context.read<MenuViewModel>().getTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: context.read<MenuViewModel>().state.items,
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
