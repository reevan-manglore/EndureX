import 'dart:async';

import 'package:endurex/pages/home_page/widgets/badge_display.dart';
import 'package:flutter/material.dart';

import '../../../models/steps_api_response.dart';
import '../../../services/fit_service.dart';

class OverallActivityCard extends StatelessWidget {
  const OverallActivityCard({super.key});
  Stream<StepsApiResponse> fetchPeriodicStepsData() async* {
    yield* FitService.fetchTodaysStepData().asStream();
    yield* Stream.periodic(const Duration(seconds: 10), (_) {
      return FitService.fetchTodaysStepData();
    }).asyncMap((event) async => await event);
  }

  Widget _buildError(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
      ),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      height: 250.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [Colors.indigo.shade300, Colors.indigo.shade500],
        ),
      ),
      child: StreamBuilder(
        stream: fetchPeriodicStepsData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return _buildError(context, "Some Error While Fetching Data");
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: BadgeDisplay(steps: snapshot.data!.steps),
                ),
                snapshot.data!.steps > 1000
                    ? const Text(
                        "Congratulations on your well-deserved success ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      )
                    : SizedBox()
              ],
            );
          }
          return _buildError(context, "Sorry No Data Found");
        },
      ),
    );
  }
}
