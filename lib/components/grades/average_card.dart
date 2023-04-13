import 'package:flutter/material.dart';

class AverageCard extends StatelessWidget {
  final int grade;

  const AverageCard({Key? key, required this.grade})
      : super(key: key);

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
                'Média',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                grade.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
