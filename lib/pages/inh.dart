import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  factory AppUtils() {
    return _singleton;
  }

  AppUtils._internal();
  static final AppUtils _singleton = AppUtils._internal();

  double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }

  double radianToDegree(double radian) {
    return radian * 180 / math.pi;
  }

  Future<bool> tryToLaunchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

class BarChartSample5 extends StatefulWidget {
  const BarChartSample5({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample5State();
}

class BarChartSample5State extends State<BarChartSample5> {
  static const double barWidth = 52;
  static const shadowOpacity = 0.2;
  static const mainItems = <int, List<double>>{
    0: [60, 40],
  };
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Сумма баллов ИЗП';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style),
    );
  }

  Widget topTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.white, fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Сумма баллов ИЗП';
        break;
      default:
        return Container();
    }
    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black45, fontSize: 10);
    String text;
    if (value == 0) {
      text = '0';
    } else {
      text = '${value.toInt()}%';
    }
    return SideTitleWidget(
      angle: AppUtils().degreeToRadian(value < 0 ? -45 : 45),
      meta: meta,
      space: 4,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget rightTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.white, fontSize: 10);
    String text;
    if (value == 0) {
      text = '0';
    } else {
      text = '${value.toInt()}0k';
    }
    return SideTitleWidget(
      angle: AppUtils().degreeToRadian(90),
      meta: meta,
      space: 0,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  BarChartGroupData generateGroup(
    int x,
    double value1,
    double value2
  ) {
    final isTop = value1 > 0;
    final sum = value1 + value2;
    final isTouched = touchedIndex == x;
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: isTouched ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: sum,
          width: barWidth,
          borderRadius: isTop
              ? const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                )
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
          rodStackItems: [
            BarChartRodStackItem(
              0,
              value1,
              AppColors.contentColorGreen,
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
            BarChartRodStackItem(
              value1,
              value1 + value2,
              AppColors.contentColorYellow,
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
            BarChartRodStackItem(
              value1 + value2,
              value1 + value2,
              AppColors.contentColorPink,
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
            BarChartRodStackItem(
              value1 + value2,
              value1 + value2,
              AppColors.contentColorBlue,
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
          ],
        ),
        // BarChartRodData(
        //   toY: -sum,
        //   width: barWidth,
        //   color: Colors.transparent,
        //   borderRadius: isTop
        //       ? const BorderRadius.only(
        //           bottomLeft: Radius.circular(6),
        //           bottomRight: Radius.circular(6),
        //         )
        //       : const BorderRadius.only(
        //           topLeft: Radius.circular(6),
        //           topRight: Radius.circular(6),
        //         ),
          // rodStackItems: [
          //   BarChartRodStackItem(
          //     0,
          //     -value1,
          //     AppColors.contentColorGreen.withValues(
          //         alpha: isTouched ? shadowOpacity * 2 : shadowOpacity),
          //     const BorderSide(color: Colors.transparent),
          //   ),
          //   BarChartRodStackItem(
          //     -value1,
          //     -(value1 + value2),
          //     AppColors.contentColorYellow.withValues(
          //         alpha: isTouched ? shadowOpacity * 2 : shadowOpacity),
          //     const BorderSide(color: Colors.transparent),
          //   ),
          //   BarChartRodStackItem(
          //     -(value1 + value2),
          //     -(value1 + value2),
          //     AppColors.contentColorPink.withValues(
          //         alpha: isTouched ? shadowOpacity * 2 : shadowOpacity),
          //     const BorderSide(color: Colors.transparent),
          //   ),
          //   BarChartRodStackItem(
          //     -(value1 + value2),
          //     -(value1 + value2),
          //     AppColors.contentColorBlue.withValues(
          //         alpha: isTouched ? shadowOpacity * 2 : shadowOpacity),
          //     const BorderSide(color: Colors.transparent),
          //   ),
          // ],
        // ),
      ],
    );
  }

  bool isShadowBar(int rodIndex) => rodIndex == 1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            maxY: 100,
            minY: 0,
            groupsSpace: 12,
            barTouchData: BarTouchData(
              handleBuiltInTouches: false,
              touchCallback: (FlTouchEvent event, barTouchResponse) {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  setState(() {
                    touchedIndex = -1;
                  });
                  return;
                }
                final rodIndex = barTouchResponse.spot!.touchedRodDataIndex;
                if (isShadowBar(rodIndex)) {
                  setState(() {
                    touchedIndex = -1;
                  });
                  return;
                }
                setState(() {
                  touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                });
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: topTitles,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: bottomTitles,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: leftTitles,
                  interval: 10,
                  reservedSize: 42,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: rightTitles,
                  interval: 10,
                  reservedSize: 42,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              checkToShowVerticalLine: (value) => value % 20 == 0,
              getDrawingVerticalLine: (value) {
                if (value == 0) {
                  return FlLine(
                    color: AppColors.borderColor.withValues(alpha: 0.1),
                    strokeWidth: 3,
                  );
                }
                return FlLine(
                  color: AppColors.borderColor.withValues(alpha: 0.1),
                  strokeWidth: 3,
                );
              },
            ),
            borderData: FlBorderData(
              show: false
            ),
            barGroups: mainItems.entries
                .map(
                  (e) => generateGroup(
                    e.key,
                    e.value[0],
                    e.value[1],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
} 