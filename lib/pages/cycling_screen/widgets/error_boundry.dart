import 'package:flutter/material.dart';

class ErrorBoundry extends StatelessWidget {
  final String message;
  const ErrorBoundry({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_outlined,
              size: 100,
              color: Theme.of(context).colorScheme.onError,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).colorScheme.onError,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
