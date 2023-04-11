import 'package:flutter/material.dart';

import '../components/class_card.dart';

class ClassesScheduleScreen extends StatelessWidget {
  const ClassesScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Minhas aulas',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Expanded(
              child: ListView(
                children: [
                  ClassCard(
                    subject: 'C317',
                    date: 'Sexta-feira 19:30 - 21:10',
                    location: 'Teams',
                  ),
                  ClassCard(
                    subject: 'C202',
                    date: 'Quinta-feira 13:30 - 15:10',
                    location: 'I-15',
                  ),
                  ClassCard(
                    subject: 'C214',
                    date: 'Segunda-feira 10:00 - 11:40',
                    location: 'I-17',
                  ),
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
