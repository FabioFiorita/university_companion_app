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
                    subject: 'Matemática',
                    date: 'Terça-feira 10:00 - 12:00',
                    location: 'Aula 1',
                  ),
                  ClassCard(
                    subject: 'Matemática',
                    date: 'Sexta-feira 10:00 - 12:00',
                    location: 'Aula 1',
                  ),
                  ClassCard(
                    subject: 'Matemática',
                    date: 'Quarta-feira 10:00 - 12:00',
                    location: 'Aula 1',
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
