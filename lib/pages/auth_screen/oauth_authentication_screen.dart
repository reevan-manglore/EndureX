import 'package:endurex/pages/home_page/home_page.dart';
import 'package:endurex/services/outh_authentication_service.dart';
import 'package:flutter/material.dart';

class OauthAutheneticationScreen extends StatefulWidget {
  const OauthAutheneticationScreen({super.key});
  static const String routeName = "/oauth-authenetication-screen";

  @override
  State<OauthAutheneticationScreen> createState() =>
      _OauthAutheneticationScreenState();
}

class _OauthAutheneticationScreenState
    extends State<OauthAutheneticationScreen> {
  bool? _isAuthSucess = null;
  @override
  void initState() {
    _signIn();
    super.initState();
  }

  void _signIn() {
    setState(() {
      _isAuthSucess = null;
    });
    OauthAuthenticationService.signIn().then((value) => {
          if (value == true)
            {
              Navigator.of(context).pushReplacementNamed(
                HomePage.routeName,
              ),
            }
          else
            {
              setState(() {
                _isAuthSucess = false;
              }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Verify Your Identity",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: _isAuthSucess == false
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Something Went Wrong During Authentication Please Try Again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _signIn();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor:
                          Colors.black26, //gives good spalsh effect
                      iconColor: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.restart_alt,
                      size: 38,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Try Again",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
