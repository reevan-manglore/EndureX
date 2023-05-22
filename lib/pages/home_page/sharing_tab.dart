import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:share_plus/share_plus.dart';

import '../../services/fit_service.dart';
import '../../services/outh_authentication_service.dart';

import '../cycling_screen/widgets/error_boundry.dart';
import './widgets/badge_display.dart';
import '../running_screen/widgets/todays_activity_chart.dart';

class SharingUiTab extends StatelessWidget {
  SharingUiTab({super.key});

  WidgetsToImageController controller = WidgetsToImageController();

  void _shareImage(BuildContext context) async {
    Uint8List? bytes = await controller.capture();
    if (bytes == null) return;
    Share.shareXFiles(
      [
        XFile.fromData(
          bytes,
          mimeType: "png",
          name: "${OauthAuthenticationService.userName}'s activity result",
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FitService.fetchLast7daysStepsData(),
      builder: (context, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        if (dataSnapshot.hasError) {
          print(dataSnapshot.error);
          return const ErrorBoundry(
            message: "Some Error Occured While Fetching Data",
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Share This Image",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
            WidgetsToImage(
              controller: controller,
              child: _SharingCard(
                userName: OauthAuthenticationService.userName ?? "",
                steps: dataSnapshot.data!.last.steps,
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton.icon(
                onPressed: () {
                  _shareImage(context);
                },
                icon: const Icon(
                  Icons.file_upload_outlined,
                  size: 42,
                ),
                label: const Text(
                  "Share",
                  style: TextStyle(fontSize: 38),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SharingCard extends StatelessWidget {
  final String userName;
  final int steps;
  const _SharingCard({super.key, required this.userName, required this.steps});
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        height: 330,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.cyan.shade300, Colors.cyan.shade500],
          ),
        ),
        child: Column(
          children: [
            Text(
              "$userName  completed ".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$steps  steps ".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: steps > 1000
                  ? BadgeDisplay(
                      steps: steps,
                    )
                  : SizedBox(
                      child: TodaysActivityChart(numberOfSteps: steps),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
