import 'package:c317_mobile/components/error_handler.dart';
import 'package:c317_mobile/providers/subject_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Consumer<SubjectProvider>(
              builder: (_, store, __) {
                if (store.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (store.error != null) {
                  return ErrorHandler(error: store.error!);
                }
                final subjects = store.subjects;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      return SubjectCard(
                        subject: subjects[index].name,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
