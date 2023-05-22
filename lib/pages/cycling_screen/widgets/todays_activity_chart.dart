import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TodaysActivityChart extends StatelessWidget {
  final double metersCycled;

  const TodaysActivityChart({
    super.key,
    required this.metersCycled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 325,
      width: double.infinity,
      child: SfCircularChart(
        margin: const EdgeInsets.all(0.0),
        series: <CircularSeries>[
          RadialBarSeries(
            dataSource: [metersCycled],
            xValueMapper: (data, _) => data,
            yValueMapper: (data, _) => data,
            pointColorMapper: (_, __) => Theme.of(context).colorScheme.primary,
            // Radius of the radial bar
            radius: '80%',
            gap: "22.0",
            innerRadius: "95.0",
            maximumValue: 3000,
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
                    "${metersCycled.toStringAsFixed(2)}M (${(metersCycled / 1000).toStringAsFixed(2)}KM)",
                    style: const TextStyle(fontSize: 24),
                  ),
                  const Divider(
                    indent: 25,
                    endIndent: 25,
                    color: Colors.white60,
                  ),
                  const Text(
                    "3000M (3KM)",
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
