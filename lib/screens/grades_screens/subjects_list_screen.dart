import 'package:flutter/material.dart';

import '../../components/grades/subject_card.dart';


class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materias'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Matérias do semestre',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Expanded(
              child: ListView(
                children: const [
                  SubjectCard(
                    subject: 'C317',
                  ),
                  SubjectCard(
                    subject: 'H003',
                  ),
                  SubjectCard(
                    subject: 'H004',
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
