import 'package:flutter/material.dart';

import './widgets/custom_appbar.dart';
import "./home_tab.dart";
import './sharing_tab.dart';
import './eye_exercise_tab.dart';
import '../../services/outh_authentication_service.dart';
import '../auth_screen/oauth_authentication_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home-page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  final _tabs = [const HomePageUiTab(), EyeExerciseTab(), SharingUiTab()];
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      name: OauthAuthenticationService.userName ?? "",
                      profilePhoto: OauthAuthenticationService.profilePhoto,
                    ),
                    Expanded(child: _tabs[_selectedTab])
                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (pressedOption) => setState(() {
                _selectedTab = pressedOption;
              }),
          currentIndex: _selectedTab,
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.remove_red_eye,
              ),
              label: 'Eye Exercise',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.share_rounded,
              ),
              label: 'Share',
            ),
          ]),
    );
  }

  @override
  void initState() {
    _checkIsAuthenticated();
    super.initState();
  }

  Future<void> _checkIsAuthenticated() async {
    setState(() {
      _isLoading = true;
    });
    final isSignedIn = await OauthAuthenticationService.isSignedIn();
    if (!isSignedIn) {
      final hasPreviouslyLoggedInUser =
          await OauthAuthenticationService.trySignInSilently();
      if (hasPreviouslyLoggedInUser) return;
      if (!mounted) return;
      Navigator.of(context)
          .pushReplacementNamed(OauthAutheneticationScreen.routeName);
    }
    await OauthAuthenticationService.trySignInSilently();
    setState(() {
      _isLoading = false;
    });
  }
}
