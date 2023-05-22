import 'dart:ui';

import 'package:flutter/material.dart';

class BadgeDisplay extends StatelessWidget {
  final int steps;

  const BadgeDisplay({super.key, required this.steps});
  Widget buildAvatar(BuildContext context, String name, String imageLocation) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imageLocation),
            radius: 45,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return steps < 1000
        ? Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    const AssetImage("lib/assets/images/no_badges_present.png"),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.grey.shade600, BlendMode.darken),
              ),
            ),
            child: const Center(
              child: Text(
                "Sorry, no badges this time. Keep going, you got this!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : GridView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 15,
            ),
            children: [
              if (steps >= 1000)
                buildAvatar(
                  context,
                  "Stepping Stone",
                  "lib/assets/images/badge_1.png",
                ),
              if (steps >= 1500)
                buildAvatar(
                    context, "Stride Master", "lib/assets/images/badge_2.png"),
              if (steps >= 2000)
                buildAvatar(
                    context, "Trailblazer", "lib/assets/images/badge_2.png"),
            ],
          );
  }
}
