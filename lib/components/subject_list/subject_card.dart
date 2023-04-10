import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String subject;

  SubjectCard({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Icon(Icons.arrow_forward_ios_sharp),
            ],
          ),
        ),
      ),
    );
  }
}
