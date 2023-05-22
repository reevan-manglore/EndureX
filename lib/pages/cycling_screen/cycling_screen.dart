import 'dart:math';
import 'package:endurex/services/fit_service.dart';
import 'package:flutter/material.dart';

import './widgets/custom_app_bar.dart';
import './widgets/todays_activity_chart.dart';
import './widgets/weekly_activity_chart.dart';
import './widgets/error_boundry.dart';

import '../../models/cycling_api_response.dart';

class CyclingScreen extends StatelessWidget {
  const CyclingScreen({super.key});
  static const routeName = "/cycling-screen";
  Widget _buildSideHeadding(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder(
        future: FitService.fetchLast7daysCyclingData(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: const CircularProgressIndicator());
          }
          if (dataSnapshot.hasError) {
            print(dataSnapshot.error);
            return const ErrorBoundry(
              message: "Some Error Occured While Fetching Data",
            );
          }
          print(dataSnapshot.data);
          // print("${dataSnapshot.data?.date},${dataSnapshot.data?.steps}");
          // dataSnapshot.data?.forEach((element) {
          //   print("${element.date},${element.steps}");
          // });
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSideHeadding("Today's Cycling Activity Snapshot"),
                  TodaysActivityChart(
                    metersCycled: dataSnapshot.data?.last.distanceCoverd ?? 0.0,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildSideHeadding(
                    "Last 7 days Cycling Activity Snapshot",
                  ),
                  WeeklyActivityChart(
                    temp: dataSnapshot.data!.sublist(
                      0,
                      dataSnapshot.data!.length - 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<CyclingApiResponse> _getDummyCyclingData() {
  List<CyclingApiResponse> temp = [];
  for (int i = 7; i >= 0; i--) {
    temp.add(
      CyclingApiResponse(
        date: DateTime.now().subtract(Duration(days: i)),
        distanceCoverd: Random().nextDouble() * 6000,
      ),
    );
  }
  return temp;
}
