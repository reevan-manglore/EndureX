import 'package:flutter/material.dart';

import '../../services/fit_service.dart';
import './widgets/todays_activity_chart.dart';
import './widgets/error_boundry.dart';
import './widgets/weekly_activity_chart.dart';
import './widgets/custom_app_bar.dart';

//imports to delete
import '../../models/steps_api_response.dart';
import 'dart:math';

class RunningScreen extends StatelessWidget {
  const RunningScreen({super.key});
  static const routeName = "/running-screen";
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
        future: FitService.fetchLast7daysStepsData(),
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
                  _buildSideHeadding("Today's Running Activity Snapshot"),
                  TodaysActivityChart(
                    numberOfSteps: dataSnapshot.data?.last.steps ?? 0,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildSideHeadding(
                    "Last 7 days Running Activity Snapshot",
                  ),
                  WeeklyActivityChart(
                    steps: dataSnapshot.data!
                        .sublist(0, dataSnapshot.data!.length - 1),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<StepsApiResponse> _getDummySteps() {
    List<StepsApiResponse> temp = [];
    for (int i = 7; i >= 0; i--) {
      temp.add(
        StepsApiResponse(
          date: DateTime.now().subtract(Duration(days: i)),
          steps: Random().nextInt(7000),
        ),
      );
    }
    return temp;
  }
}
