import 'package:endurex/pages/auth_screen/oauth_authentication_screen.dart';
import 'package:endurex/services/outh_authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String name;
  late final String profilePhoto;
  CustomAppBar({required this.name, String? profilePhoto, super.key}) {
    this.profilePhoto = profilePhoto ?? "$diceBearUrl?seed=${"cookie"}";
  }
  AlertDialog _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text(
        "Are you sure to logout?",
        style: TextStyle(
          fontSize: 32,
        ),
      ),
      content: const Text(
        "You will be logged out of this app",
        style: TextStyle(
          fontSize: 23,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          ),
          child: Text(
            "No",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            OauthAuthenticationService.signOut().then(
              (value) => Navigator.of(context)
                  .pushReplacementNamed(OauthAutheneticationScreen.routeName),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
          child: Text(
            "Yes",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hello",
                  style: GoogleFonts.teko(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                Text(
                  name.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                  style: GoogleFonts.teko(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () =>
                {showDialog(context: context, builder: _buildAlertDialog)},
            child: CircleAvatar(
              radius: 28,
              backgroundImage:
                  NetworkImage(profilePhoto, scale: double.maxFinite),
              backgroundColor: Colors.indigo.shade300,
            ),
          )
        ],
      ),
    );
  }
}
