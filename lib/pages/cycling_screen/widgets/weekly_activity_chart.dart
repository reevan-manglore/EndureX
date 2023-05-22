import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:math';
import '../../../models/cycling_api_response.dart';
import 'package:intl/intl.dart';

class WeeklyActivityChart extends StatelessWidget {
  WeeklyActivityChart({
    super.key,
    required this.temp,
  }) {
    // extract max number of steps walked by user in that week
    maxDistanceToBePlotted = temp.fold(
        temp.first.distanceCoverd.round(),
        (max, currVal) => currVal.distanceCoverd.round() > max
            ? currVal.distanceCoverd.round()
            : max);
    maxDistanceToBePlotted =
        maxDistanceToBePlotted ~/ 1000; //extract only leading two digits
    /*
      increase that maxStepsToBePlotted one number to ensure all 
      labels are visible and then 
      multiply by 1000 to make it in thousand
    */
    maxDistanceToBePlotted = (maxDistanceToBePlotted + 1) * 1000;
  }

  final List<CyclingApiResponse> temp;
  int maxDistanceToBePlotted = 0;

  List<ColumnSeries<CyclingApiResponse, String>> _getRoundedColumnSeries(
      BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final formater = DateFormat("E");
    return <ColumnSeries<CyclingApiResponse, String>>[
      ColumnSeries<CyclingApiResponse, String>(
        width: 0.5,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          labelAlignment: ChartDataLabelAlignment.outer,
        ),
        dataSource: [
          temp[0],
          ...temp.sublist(1).reversed.toList(),
        ],

        /// If we set the border radius value for column series,
        /// then the series will appear as rounder corner.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        color: primaryColor.withOpacity(0.7),
        xValueMapper: (sales, _) => formater.format(sales.date),
        yValueMapper: (CyclingApiResponse sales, _) => double.parse(
          sales.distanceCoverd.toStringAsFixed(2),
          //implmented above code to ensure that there are two numbers after decimal point
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return SfCartesianChart(
      plotAreaBorderWidth: 0,

      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(
          width: 0,
        ),
        axisLine: const AxisLine(
          //to draw x axis line
          width: 1,
          color: Colors.white54,
        ),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: max(
          5000.00,
          maxDistanceToBePlotted.toDouble(),
        ), //minimum of labels till 5000 should exist
        axisLine: const AxisLine(
          //to draw x axis line
          width: 1,
          color: Colors.white54,
        ),
        plotBands: [
          PlotBand(
            //horiztal dooted reference steps for healthy living
            start: 3000,
            end: 3050,
            horizontalTextAlignment: TextAnchor.start,
            color: primaryColor,
            borderWidth: 10,
            dashArray: const [10, 6],
            text: "3000M (3KM)",

            textStyle: TextStyle(
              fontSize: 10,
              color: primaryColor,
            ),
          ),
        ],
        labelStyle: const TextStyle(
          color: Colors.white54, // set the color of interval numbers to whitish
        ),
        majorGridLines: const MajorGridLines(
          color: Colors.white54,
        ),
        majorTickLines: const MajorTickLines(
          size: 0,
        ),
      ),
      series: _getRoundedColumnSeries(context), //Numeric axis along y axis
    );
  }
}
