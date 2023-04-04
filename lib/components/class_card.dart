import 'package:flutter/material.dart';

class ClassCard extends StatelessWidget {
  final String subject;
  final String date;
  final String location;

  ClassCard(
      {Key? key,
      required this.subject,
      required this.date,
      required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Text(
                  date,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Text(
                ('Sala: $location'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
