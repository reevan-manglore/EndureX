import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/steps_api_response.dart';
import '../models/cycling_api_response.dart';
import 'outh_authentication_service.dart';
import '../constants/constants.dart';

class FitService {
  static Future<StepsApiResponse> fetchTodaysStepData() async {
    final today = DateTime.now();
    final data = await _fetchStepsData(
      durationInMilliSeconds: const Duration(days: 1).inMilliseconds,
      startTimeInMilliSeconds: DateTime.parse(
        DateFormat("yyyy-MM-dd").format(today),
      ).millisecondsSinceEpoch,
      endTimeInMilliSeconds: today.millisecondsSinceEpoch,
    );
    return StepsApiResponse.fromJson(today, data);
  }

  static Future<StepsApiResponse> fetchLast24hrsStepsData() async {
    final today = DateTime.now();
    final data = await _fetchStepsData(
      durationInMilliSeconds: const Duration(hours: 24).inMilliseconds,
      startTimeInMilliSeconds: today
          .subtract(
            const Duration(hours: 24),
          )
          .millisecondsSinceEpoch,
      endTimeInMilliSeconds: today.millisecondsSinceEpoch,
    );

    return StepsApiResponse.fromJson(today, data);
  }

  static Future<List<StepsApiResponse>> fetchLast7daysStepsData() async {
    final today = DateTime.now();
    final List<StepsApiResponse> steps = [];
    final List<Future<dynamic>> constructedApiCalls = [];
    for (int i = 7; i >= 0; i--) {
      final dateToUse = today.subtract(
        Duration(days: i),
      );
      final startTime =
          DateTime.parse(DateFormat("yyyy-MM-dd").format(dateToUse))
              .millisecondsSinceEpoch;

      final endTime = DateTime.parse(
        DateFormat("yyyy-MM-dd 23:59:59").format(dateToUse),
      ).millisecondsSinceEpoch;

      constructedApiCalls.add(_fetchStepsData(
        durationInMilliSeconds: const Duration(days: 1).inMilliseconds,
        startTimeInMilliSeconds: startTime,
        endTimeInMilliSeconds: endTime,
      ));
    }
    final responses = await Future.wait(constructedApiCalls);
    for (int i = 7; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      steps.add(StepsApiResponse.fromJson(date, responses[i]));
    }

    return steps.reversed.toList();
  }

  static Future<CyclingApiResponse> fetchTodaysCyclingData() async {
    final today = DateTime.now();
    final data = await _fetchDistanceCoverdByCycling(
      durationInMilliSeconds: const Duration(days: 2).inMilliseconds,
      startTimeInMilliSeconds: DateTime.parse(
        DateFormat("yyyy-MM-dd")
            .format(today.subtract(const Duration(days: 2))),
      ).millisecondsSinceEpoch,
      endTimeInMilliSeconds:
          today.subtract(const Duration(days: 1)).millisecondsSinceEpoch,
    );
    return CyclingApiResponse.fromJson(today, data);
  }

  static Future<List<CyclingApiResponse>> fetchLast7daysCyclingData() async {
    final today = DateTime.now();
    final List<CyclingApiResponse> cyclingDistances = [];
    final List<Future<dynamic>> constructedApiCalls = [];
    for (int i = 7; i >= 0; i--) {
      final dateToUse = today.subtract(
        Duration(days: i),
      );
      final startTime =
          DateTime.parse(DateFormat("yyyy-MM-dd").format(dateToUse))
              .millisecondsSinceEpoch;

      final endTime = DateTime.parse(
        DateFormat("yyyy-MM-dd 23:59:59").format(dateToUse),
      ).millisecondsSinceEpoch;

      constructedApiCalls.add(_fetchDistanceCoverdByCycling(
        durationInMilliSeconds: const Duration(days: 1).inMilliseconds,
        startTimeInMilliSeconds: startTime,
        endTimeInMilliSeconds: endTime,
      ));
    }
    final responses = await Future.wait(constructedApiCalls);
    for (int i = 0; i <= 7; i++) {
      final date = today.subtract(
        Duration(days: i),
      );
      cyclingDistances.add(
        CyclingApiResponse.fromJson(date, responses[i]),
      );
    }
    cyclingDistances.forEach((element) {
      print(element.date);
    });
    return cyclingDistances;
  }

  static Future<dynamic> _fetchStepsData({
    required int durationInMilliSeconds,
    required int startTimeInMilliSeconds,
    required endTimeInMilliSeconds,
  }) async {
    final uri = Uri.parse(googleFitDatasetAgregateEndpoint);
    final token = await OauthAuthenticationService.token;
    final res = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer ${token}",
        "Accept": "application/json",
      },
      body: json.encode({
        "aggregateBy": [
          {
            "dataSourceId":
                "derived:com.google.step_count.delta:com.google.android.gms:estimated_steps" //dont modify this
          }
        ],
        "bucketByTime": {"durationMillis": durationInMilliSeconds},
        "startTimeMillis": startTimeInMilliSeconds,
        "endTimeMillis": endTimeInMilliSeconds,
      }),
    );
    print("status code is ${res.statusCode}");
    final data = json.decode(res.body);
    return data;
  }

  static Future<dynamic> _fetchDistanceCoverdByCycling({
    required int durationInMilliSeconds,
    required int startTimeInMilliSeconds,
    required endTimeInMilliSeconds,
  }) async {
    final uri = Uri.parse(googleFitDatasetAgregateEndpoint);
    final token = await OauthAuthenticationService.token;
    final res = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer ${token}",
        "Accept": "application/json",
      },
      body: json.encode({
        "aggregateBy": [
          {
            "dataTypeName": "com.google.distance.delta",
            "dataSourceId":
                "derived:com.google.distance.delta:com.google.android.gms:merge_distance_delta"
          }
        ],
        "bucketByTime": {"durationMillis": durationInMilliSeconds},
        "startTimeMillis": startTimeInMilliSeconds,
        "endTimeMillis": endTimeInMilliSeconds,
      }),
    );

    print("cycling status code is ${res.statusCode}");
    final data = json.decode(res.body);
    print("cycling data is ${data}");
    return data;
  }
}
