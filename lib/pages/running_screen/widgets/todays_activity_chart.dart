import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TodaysActivityChart extends StatelessWidget {
  final int numberOfSteps;

  const TodaysActivityChart({super.key, required this.numberOfSteps});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: SfCircularChart(
        margin: const EdgeInsets.all(0.0),
        series: <CircularSeries>[
          RadialBarSeries(
            dataSource: [numberOfSteps],
            xValueMapper: (data, _) => data,
            yValueMapper: (data, _) => data,
            pointColorMapper: (_, __) => Theme.of(context).colorScheme.primary,
            // Radius of the radial bar
            radius: '80%',
            gap: "22.0",
            innerRadius: "80.0",
            maximumValue: 5000,
            trackColor: Theme.of(context).colorScheme.primaryContainer,
            trackOpacity: 0.7,
            cornerStyle: CornerStyle.bothCurve,
          )
        ],
        annotations: [
          CircularChartAnnotation(
            angle: 0,
            radius: '0%',
            height: '100%',
            width: '100%',
            widget: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$numberOfSteps",
                    style: const TextStyle(fontSize: 24),
                  ),
                  const Divider(
                    indent: 25,
                    endIndent: 25,
                    color: Colors.white60,
                  ),
                  const Text(
                    "5000 Steps",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
