import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';

class IndividualActivityCard extends StatelessWidget {
  final String activityName;
  final String backgroundImage;
  final void Function() whenTapped;
  const IndividualActivityCard({
    required this.activityName,
    required this.backgroundImage,
    required this.whenTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: whenTapped,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 8.0,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.black26,
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(15.0),
          border: const GradientBoxBorder(
            width: 1.5,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              colors: [Colors.black54, Colors.white60],
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade200, Colors.purple.shade500],
          ),
        ),
        child: Ink(
          width: double.infinity,
          height: double.infinity,
          color: Colors.purple.shade100,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    activityName,
                    style: GoogleFonts.teko(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 30.0,
                    weight: 600,
                    color: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
