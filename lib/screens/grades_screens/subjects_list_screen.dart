import 'package:c317_mobile/providers/subjects_provider.dart';
import 'package:c317_mobile/service/subject_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/grades/subject_card.dart';
import '../../models/subject.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SubjectService subjectService = SubjectService(context: context);
    final subjectProvider =
        Provider.of<SubjectsProvider>(context, listen: false);
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
              child: FutureBuilder<bool>(
                future: subjectProvider.getSubjects(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final subjects = subjectProvider.subjects;
                    return ListView.builder(
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        return SubjectCard(
                          subject: subjects[index].code,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
