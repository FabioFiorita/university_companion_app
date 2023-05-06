import 'package:c317_mobile/exceptions/class_exception.dart';
import 'package:c317_mobile/exceptions/user_exception.dart';
import 'package:c317_mobile/providers/class_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../components/class_card.dart';
import '../components/error_body.dart';

class ClassesScheduleScreen extends StatelessWidget {
  ClassesScheduleScreen({Key? key}) : super(key: key);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
            Consumer<ClassProvider>(
              builder: (_, store, __) {
                final classes = store.classes;
                if (classes.isEmpty) {
                  return _handleError(ClassException.classNotFound);
                }
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: classes.length,
                    itemBuilder: (context, index) {
                      return ClassCard(
                        subject: classes[index].subject.name,
                        date: classes[index].date,
                        location: classes[index].location,
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
