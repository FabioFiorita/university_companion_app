import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingPage extends StatelessWidget {
  IconData icon;
  String title;
  String description;

  OnboardingPage(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description})
      : super(key: key);

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
            ).animate(delay: 200.ms).then().fadeIn(duration: 700.ms, delay: 300.ms).move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ).animate(delay: 400.ms).then().fadeIn(duration: 700.ms, delay: 300.ms).move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ).animate(delay: 600.ms).then().fadeIn(duration: 700.ms, delay: 300.ms).move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
          ],
        ),
      ),
    );
  }
}
