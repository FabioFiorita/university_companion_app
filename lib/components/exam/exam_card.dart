import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  final String exam;
  int? grade;

  ExamCard({Key? key, required this.exam, this.grade}) : super(key: key);

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
                exam,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              (grade != null)
                  ? Text(
                      grade.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  : TextField(
                      enabled: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
