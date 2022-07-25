import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../template/misc/colors.dart';

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 4,
        minY: 0,
        maxY: 2,
        titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              axisNameWidget: Row(
                children: [
                  Text(
                    '25/7/2022',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '1/8/2022',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            leftTitles: AxisTitles(
              //drawBehindEverything: false,
              axisNameWidget: Row(
                children: [
                  Spacer(),
                  Text(
                    '35',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '70',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            topTitles: AxisTitles(
              axisNameWidget: Container(),
            ),
            rightTitles: AxisTitles(
              axisNameWidget: Container(),
            )),
        gridData: FlGridData(
          show: true,
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: const Color(0xff37434d),
            width: 1,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 0),
              FlSpot(1, 1),
              FlSpot(2, 1),
              FlSpot(4, 2),
            ],
            //dotData: FlDotData(show:),
            gradient: AppColors.colorGradient,
            barWidth: 2,
            belowBarData: BarAreaData(
              show: true,
              gradient: AppColors.colorGradient,
            ),
          )
        ],
      ),
    );
  }
}
