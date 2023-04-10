import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  IconData icon;
  String title;
  String description;
  OnboardingPage({Key? key, required this.icon, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Text(description,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
