import 'package:c317_mobile/exceptions/class_exception.dart';
import 'package:c317_mobile/exceptions/user_exception.dart';
import 'package:c317_mobile/providers/class_provider.dart';
import 'package:c317_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/class_card.dart';
import '../components/error_body.dart';

class ClassesScheduleScreen extends StatelessWidget {
  const ClassesScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClassProvider classProvider =
        Provider.of<ClassProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
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
              child: FutureBuilder<void>(
                future: classProvider.getClasses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return _handleError(snapshot.error);
                    }
                    final classes = classProvider.classes;
                    return ListView.builder(
                      itemCount: classes.length,
                      itemBuilder: (context, index) {
                        return ClassCard(
                          subject: classes[index].subject.name,
                          date: classes[index].date,
                          location: classes[index].location,
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
    if (error is ClassException) {
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
