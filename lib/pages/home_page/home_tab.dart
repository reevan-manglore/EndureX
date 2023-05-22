import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cycling_screen/cycling_screen.dart';
import '../running_screen/running_screen.dart';
import './widgets/individual_activity_card.dart';
import './widgets/overall_activity_card.dart';

class HomePageUiTab extends StatelessWidget {
  const HomePageUiTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const OverallActivityCard(),
        const SizedBox(
          height: 12.0,
        ),
        Text(
          "Your Activity",
          textAlign: TextAlign.left,
          style: GoogleFonts.teko(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: IndividualActivityCard(
                    activityName: "Cycling",
                    backgroundImage: "lib/assets/images/cycling_image.jpeg",
                    whenTapped: () {
                      Navigator.of(context).pushNamed(CyclingScreen.routeName);
                    },
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Flexible(
                  flex: 1,
                  child: IndividualActivityCard(
                    activityName: "Running",
                    backgroundImage: "lib/assets/images/running_image.png",
                    whenTapped: () {
                      Navigator.of(context).pushNamed(RunningScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
