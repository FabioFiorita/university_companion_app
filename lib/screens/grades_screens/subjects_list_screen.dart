import 'package:c317_mobile/components/error_body.dart';
import 'package:c317_mobile/exceptions/user_exception.dart';
import 'package:c317_mobile/providers/subject_provider.dart';
import 'package:c317_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/grades/subject_card.dart';
import '../../exceptions/subject_exception.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final SubjectProvider subjectProvider =
        Provider.of<SubjectProvider>(context, listen: false);
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
              child: FutureBuilder<void>(
                future: subjectProvider.getSubjects(userProvider.user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return _handleError(snapshot.error);
                    }
                    final subjects = subjectProvider.subjects;
                    return ListView.builder(
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        return SubjectCard(
                          subject: subjects[index].name,
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

  Widget _handleError(Object? error) {
    if (error is SubjectException) {
      return ErrorBody(
        title: error.title,
        message: error.message,
      );
    } else if (error is UserException) {
      return ErrorBody(
        title: error.title,
        message: error.message,
      );
    } else {
      return const ErrorBody();
    }
  }
}
